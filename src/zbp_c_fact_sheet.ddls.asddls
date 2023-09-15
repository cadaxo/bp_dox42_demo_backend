@AbapCatalog.sqlViewName: 'ZBPCFACTSHEET'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'bp fact sheet'
define view zbp_c_fact_sheet
  as select from zbp_fact_sheet
{
  key partner                                                                             as Partner,
      customer_fact_sheet_url                                                             as CustomerFactSheetUrl,
      created_timestamp                                                                   as CreatedTimestamp,

      tstmp_current_utctimestamp()                                                        as current_system_timestamp,

      TSTMP_SECONDS_BETWEEN( created_timestamp, tstmp_current_utctimestamp(), 'INITIAL' ) as SecondsCreated
}
