FUNCTION zcdx_dox42_central_partner.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_PARTNER_ID) TYPE  BU_PARTNER DEFAULT 0000000031
*"  EXPORTING
*"     VALUE(E_CENTRAL_DATA) TYPE  ZCDX_DOX42_CENTRAL_PARTNER
*"----------------------------------------------------------------------

  DATA lt_lines TYPE TABLE OF tline.
  DATA lt_html TYPE TABLE OF htmlline.
  DATA lx_html TYPE xstring.

  SELECT SINGLE
    FROM zcdx_business_partner "but000
    FIELDS partner,
           type,
           FullName AS name,
           DateOfBirth AS Birthdt,
           CentralBlocked AS xblck,

           City,
           StreetAndNr,
           PostCode,
           Country

    WHERE partner = @i_partner_id
    INTO CORRESPONDING FIELDS OF @e_central_data.

  e_central_data-birthdt_out = |{ e_central_data-birthdt DATE = USER }|.

  DATA l_header TYPE thead.
  CALL FUNCTION 'READ_TEXT'
    EXPORTING
      id                      = '0001'
      language                = sy-langu
      name                    = CONV thead-tdname( e_central_data-partner )
      object                  = 'BUT000'
    IMPORTING
      header                  = l_header
    TABLES
      lines                   = lt_lines
    EXCEPTIONS
      id                      = 1
      language                = 2
      name                    = 3
      not_found               = 4
      object                  = 5
      reference_check         = 6
      wrong_access_to_archive = 7
      OTHERS                  = 8.
  IF sy-subrc = 0.

    CALL FUNCTION 'CONVERT_ITF_TO_HTML'
      EXPORTING
        i_header       = l_header
      TABLES
        t_itf_text     = lt_lines
        t_html_text    = lt_html
      EXCEPTIONS
        syntax_check   = 1
        replace        = 2
        illegal_header = 3
        OTHERS         = 4.

    LOOP AT lt_html ASSIGNING FIELD-SYMBOL(<html>).
      e_central_data-note = e_central_data-note && <html>-tdline.
    ENDLOOP.

  ENDIF.

ENDFUNCTION.
