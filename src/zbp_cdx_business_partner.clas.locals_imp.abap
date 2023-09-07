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
