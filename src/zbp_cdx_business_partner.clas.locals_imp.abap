CLASS lhc_ZCDX_BUSINESS_PARTNER DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

*    METHODS create FOR MODIFY
*      IMPORTING entities FOR CREATE ZCDX_BUSINESS_PARTNER.
*
*    METHODS delete FOR MODIFY
*      IMPORTING keys FOR DELETE ZCDX_BUSINESS_PARTNER.
*
*    METHODS update FOR MODIFY
*      IMPORTING entities FOR UPDATE ZCDX_BUSINESS_PARTNER.

    METHODS read FOR READ
      IMPORTING keys FOR READ ZCDX_BUSINESS_PARTNER RESULT result.

    METHODS generateDOX42 FOR MODIFY
      IMPORTING keys FOR ACTION ZCDX_BUSINESS_PARTNER~generateDOX42 RESULT result.

    METHODS get_features FOR FEATURES
      IMPORTING keys REQUEST requested_features FOR ZCDX_BUSINESS_PARTNER RESULT result.

ENDCLASS.

CLASS lhc_ZCDX_BUSINESS_PARTNER IMPLEMENTATION.

*  METHOD create.
*  ENDMETHOD.
*
*  METHOD delete.
*  ENDMETHOD.
*
*  METHOD update.
*  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD generateDOX42.
   zcl_dox42_demos=>generate_partner_factsheet( i_partner_id =  '0000000011' ).
  ENDMETHOD.

  METHOD get_features.
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
