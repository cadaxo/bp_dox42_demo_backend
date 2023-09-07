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


  method GENERATE_PARTNER_FACTSHEET.

    " get partner data

    " create json

    " execute dox42

    " set return PDF

  endmethod.
ENDCLASS.
