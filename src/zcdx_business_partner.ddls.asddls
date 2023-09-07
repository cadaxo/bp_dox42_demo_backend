@AbapCatalog.sqlViewName: 'ZCDSBUPA_V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Main CDS View for Business Partner Data'
define root view ZCDX_BUSINESS_PARTNER 
    as select from but000 
    left outer join but020 on but020.addrnumber = but000.addrcomm
    left outer join adrc   on adrc.addrnumber = but020.addrnumber 

{
    key but000.partner as Partner,
    type as Type,
    name_first as FirstName,
    name_last as LastName,
    adrc.city1 as City
   
}
