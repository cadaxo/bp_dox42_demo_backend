class ZCL_DOX42_DEMOS definition
  public
  final
  create public .

public section.

  class-methods GENERATE_PARTNER_FACTSHEET
    importing
      !I_PARTNER_ID  type BU_PARTNER
      !I_TEMPLATE_ID type CHAR10

    returning
      value(R_PDF) type XSTRING .
protected section.
private section.
ENDCLASS.



CLASS ZCL_DOX42_DEMOS IMPLEMENTATION.


  METHOD generate_partner_factsheet.

    DATA last_error TYPE i.

* create http client to the dox42 server
    cl_http_client=>create_by_url(
     EXPORTING
       url     = 'https://azuro.dox42.com'
     IMPORTING
       client  = DATA(http_client) ).

    select single TEMPLATE_DESC
       from ZCDX_DOX42_TEMPL
       where TEMPLATE_ID = @i_template_id
       into @DATA(l_doc_template).
    if sy-subrc <> 0.
       l_doc_template =  CONV string( 'SAPFactsheet\dox42_demo_factsheet.docx' ).
    endif.

 "   DATA(l_doc_template) =  CONV string( 'SAPFactsheet\dox42_demo_factsheet.docx' ).


* create restService  & operation, template, input parameter, return action, ....
    DATA(uri) = '/dox42RestService.ashx?' &&
                'Operation=GenerateDocument' &&
                '&DocTemplate=~%5cTemplates%5c' && l_doc_template &&
                '&InputParam.i_partner_id=' &&  i_partner_id  &&
                '&ReturnAction.format=pdf' &&
                '&ReturnAction.fileName=Demo.pdf' &&
                '&ReturnAction.disp=attachment'.

* set uri
    cl_http_utility=>set_request_uri( request = http_client->request
                                      uri     = uri ).

* set method to post
    http_client->request->set_method( 'POST' ).

* get partner data (name, type, identification numbers)
    "SELECT SINGLE * FROM but000 WHERE partner = @p_partn INTO CORRESPONDING FIELDS OF @l_partner_data.

* create json writer instance
*  DATA(o_writer_json) = cl_sxml_string_writer=>create( type = if_sxml=>co_xt_json ).
*
** convert partner data json/xml
*  CALL TRANSFORMATION id SOURCE data = l_partner_data RESULT XML o_writer_json.
*  DATA(json) = cl_abap_codepage=>convert_from( o_writer_json->get_output( ) ).
*
** set json content & content type
*  http_client->request->set_content_type( content_type = 'application/XML' ).
*  http_client->request->set_cdata( json ).

* send & receive
    http_client->send( ).
    http_client->receive( ).

* get/check errors
    last_error  = http_client->response->get_last_error( ).

    data(l_string) = http_client->response->get_cdata( ).

    IF http_client->response->get_cdata( ) CS 'dox42 Service returned Error: Document generation failed'.
      MESSAGE TEXT-001 TYPE 'S'.
      RETURN.
    ENDIF.

* get response: PDF!
    r_pdf = http_client->response->get_data( ).

    DATA(length) = xstrlen( r_pdf ).

    DATA lr_response TYPE REF TO cl_http_response.
    DATA lv_url TYPE string.
    DATA ls_pdf_string_x TYPE xstring.
    DATA lv_value TYPE string.


    CREATE OBJECT lr_response
      EXPORTING
        add_c_msg = 1.

   " lv_value = 'inline; ' && 'demofile.pdf'.
 lv_value = 'demofile.pdf'.

    lr_response->set_data( data = r_pdf length = length ).
    lr_response->set_header_field( name = if_http_header_fields=>content_type value = 'application/pdf' ).
    lr_response->set_header_field( name  = 'Content-Disposition' value = lv_value ).
    lr_response->if_http_response~set_status( code = 200 reason = 'OK' ).
    lr_response->if_http_response~server_cache_expire_rel( expires_rel = 60 ).

    DATA lv_guid                TYPE guid_32.
   " CALL FUNCTION 'GUID_CREATE'
   "   IMPORTING
   "     ev_guid_32 = lv_guid.

   " get time stamp field data(l_timestamp).

    CONCATENATE  '/sap/public' '/FactSheet_' i_partner_id '.' 'PDF' INTO lv_url.

    cl_http_server=>server_cache_upload( url = lv_url response = lr_response ).

    "data(resp) =  lr_response->get_cdata( ).

    DATA ls_fact_sheet TYPE zbp_fact_sheet.
    ls_fact_sheet-partner = i_partner_id.
    ls_fact_sheet-customer_fact_sheet_url = lv_url.

    get TIME STAMP FIELD ls_fact_sheet-created_timestamp.

    MODIFY zbp_fact_sheet FROM ls_fact_sheet.


  ENDMETHOD.
ENDCLASS.
