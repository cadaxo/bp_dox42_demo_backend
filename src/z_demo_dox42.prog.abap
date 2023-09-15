*&---------------------------------------------------------------------*
*& Report Z_DEMO_DOX42
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_demo_dox42.

TYPES: BEGIN OF tp_partner,
         partner      TYPE bu_partner,
         name_org1    TYPE bu_nameor1,
         partner_guid TYPE bu_partner_guid,
       END OF tp_partner.

DATA l_partner_data TYPE tp_partner.
DATA last_error TYPE i.
DATA pdf_response TYPE xstring.

PARAMETERS: p_partn TYPE but000-partner DEFAULT '0000000101'.

START-OF-SELECTION.

PERFORM create_pdf.

PERFORM create_attachment.

FORM create_pdf.

* create http client to the dox42 server
  cl_http_client=>create_by_url(
   EXPORTING
     url     = 'https://azuro.dox42.com'
   IMPORTING
     client  = DATA(http_client) ).

      DATA(l_doc_template) =  CONV string( 'SAPFactsheet\dox42_demo_factsheet.docx' ).


* create restService  & operation, template, input parameter, return action, ....
  DATA(uri) = '/dox42RestService.ashx?' &&
              'Operation=GenerateDocument' &&
              '&DocTemplate=~%5cTemplates%5c' && l_doc_template &&
              '&InputParam.i_partner_id=' && '11' &&
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
  IF http_client->response->get_cdata( ) CS 'dox42 Service returned Error: Document generation failed'.
    MESSAGE TEXT-001 TYPE 'S'.
    RETURN.
  ENDIF.

* get response: PDF!
  pdf_response = http_client->response->get_cdata( ).

ENDFORM.


FORM create_attachment.

  DATA: gs_fol_id     TYPE soodk.
  DATA gt_content    TYPE soli_tab.
  DATA gs_obj_id     TYPE soodk.

  CALL FUNCTION 'SO_FOLDER_ROOT_ID_GET'
    EXPORTING
      region    = 'B'
    IMPORTING
      folder_id = gs_fol_id
    EXCEPTIONS
      OTHERS    = 1.

****
 DATA length TYPE i.
 CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
   EXPORTING
     buffer                = pdf_response
*    APPEND_TO_TABLE       = ' '
  IMPORTING
    output_length         = length
   TABLES
     binary_tab            = gt_content
           .





    DATA:
    ls_obj_data TYPE sood1,
    lt_objhead  TYPE STANDARD TABLE OF soli.

  ls_obj_data-objsns   = 'O'.
  ls_obj_data-objla    = sy-langu.
"  ls_obj_data-objdes   = ps_ftab-path.
  ls_obj_data-file_ext = 'PDF'.
  ls_obj_data-objlen   = lines( gt_content ) * 255.
  CONDENSE ls_obj_data-objlen.

  CALL FUNCTION 'SO_OBJECT_INSERT'
    EXPORTING
      folder_id             = gs_fol_id
      object_type           = 'EXT'
      object_hd_change      = ls_obj_data
    IMPORTING
      object_id             = gs_obj_id
    TABLES
      objhead               = lt_objhead
      objcont               = gt_content
    EXCEPTIONS
      active_user_not_exist = 35
      folder_not_exist      = 6
      object_type_not_exist = 17
      owner_not_exist       = 22
      parameter_error       = 23
      OTHERS                = 1000.

****
  DATA:
    ls_folmem_k TYPE sofmk,
    ls_note     TYPE borident,
    lv_ep_note  TYPE borident-objkey,
    ls_object   TYPE borident.

  DATA:
    ls_lpor_a TYPE sibflporb,
    ls_lpor_b TYPE sibflporb.

  ls_object-objkey  = '0000000021'.
  ls_object-objtype = 'BUS1006'.
  ls_note-objtype   = 'MESSAGE'.

  CONCATENATE gs_fol_id-objtp gs_fol_id-objyr gs_fol_id-objno
              gs_obj_id-objtp gs_obj_id-objyr gs_obj_id-objno
         INTO ls_note-objkey.

*  CALL FUNCTION 'BINARY_RELATION_CREATE_COMMIT'
*    EXPORTING
*      obj_rolea    = ls_object
*      obj_roleb    = ls_note
*      relationtype = 'ATTA'
*    EXCEPTIONS
*      OTHERS       = 1.
DATA li_model TYPE REF TO if_model_binrel.
 li_model = cl_obl_model_factory=>brel_conv_inst( 'ATTA' ).


        ls_lpor_a-instid = ls_object-objkey.
        ls_lpor_a-typeid = ls_object-objtype.
        ls_lpor_a-catid  = 'BO'.

        ls_lpor_b-instid = ls_note-objkey.
        ls_lpor_b-typeid = ls_note-objtype.
        ls_lpor_b-catid  = 'BO'.

cl_binary_relation=>create_link(
  EXPORTING
            is_object_a            = ls_lpor_a
            ip_logsys_a            = ls_object-logsys
            is_object_b            = ls_lpor_b
            ip_logsys_b            = ls_object-logsys
            ip_reltype             = li_model->gp_type ).

commit work.


data: ls_customer_Fact_sheet type ZBP_FACT_SHEET.

ls_customer_fact_sheet-partner = '0000000021'.
insert zbp_fact_sheet from @ls_customer_fact_sheet.

ENDFORM.
