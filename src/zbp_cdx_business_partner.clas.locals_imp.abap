CLASS lhc_BusinessPartner DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS read FOR READ
      IMPORTING keys FOR READ BusinessPartner RESULT result.

    METHODS generateDOX42 FOR MODIFY
      IMPORTING keys FOR ACTION BusinessPartner~generateDOX42 RESULT result.

ENDCLASS.

CLASS lhc_BusinessPartner IMPLEMENTATION.

  METHOD read.
  ENDMETHOD.

  METHOD generateDOX42.

  DATA(lt_keys) = keys.
  LOOP AT lt_keys ASSIGNING FIELD-SYMBOL(<fs_key>).

    DATA(template_id) = <fs_key>-%param-template_id.
    DATA(partner_id)  = <fs_key>-Partner.

    DATA(pdf_data) =  zcl_dox42_demos=>generate_partner_factsheet(
        i_partner_id  =  partner_id
        i_template_id =  template_id
    ).

***
  data: gs_fol_id     TYPE soodk.
  data gt_content    TYPE soli_tab.
  data gs_obj_id     TYPE soodk.

  CALL FUNCTION 'SO_FOLDER_ROOT_ID_GET'
    EXPORTING
      region    = 'B'
    IMPORTING
      folder_id = gs_fol_id
    EXCEPTIONS
      OTHERS    = 1.

****
 data length type i.
 CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
   EXPORTING
     buffer                = pdf_data
*    APPEND_TO_TABLE       = ' '
  IMPORTING
    OUTPUT_LENGTH         = length
   tables
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

  ls_object-objkey  = '0000000021'.
  ls_object-objtype = 'BUS1006'.
  ls_note-objtype   = 'MESSAGE'.

  CONCATENATE gs_fol_id-objtp gs_fol_id-objyr gs_fol_id-objno
              gs_obj_id-objtp gs_obj_id-objyr gs_obj_id-objno
         INTO ls_note-objkey.

  DATA:
    ls_lpor_a TYPE sibflporb,
    ls_lpor_b TYPE sibflporb.

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



***
  ENDLOOP.

*  result = VALUE #( FOR travel IN  ( mykey = travel-mykey
*                                              %param    = travel
*                                            ) ).

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZCDX_BUSINESS_PARTNER DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS check_before_save REDEFINITION.

    METHODS finalize          REDEFINITION.

    METHODS save              REDEFINITION.

ENDCLASS.

CLASS lsc_ZCDX_BUSINESS_PARTNER IMPLEMENTATION.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD finalize.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

ENDCLASS.
