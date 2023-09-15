@AbapCatalog.sqlViewName: 'ZCDSBUPA_V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Main CDS View for Business Partner Data'

define root view ZCDX_BUSINESS_PARTNER
  as select from    but000
    left outer join but020           on but020.partner = but000.partner
    left outer join adrc             on adrc.addrnumber = but020.addrnumber
    left outer join zbp_c_fact_sheet on zbp_c_fact_sheet.Partner = but000.partner

  association [0..*] to ZCDX_BP_BANK_DETAILS as _BankDetails on $projection.Partner = _BankDetails.partner
  association [0..*] to ZCDX_BP_ID_NUMBERS   as _IDNumbers   on $projection.Partner = _IDNumbers.partner

{
  key but000.partner                                      as Partner,
      type                                                as Type,
      name_first                                          as FirstName,
      name_last                                           as LastName,
      adrc.country                                        as Country,
      adrc.post_code1                                     as PostCode,
      concat_with_space(adrc.street, adrc.house_num1, 1)  as StreetAndNr,
      adrc.city1                                          as City,
      concat_with_space(name_first, name_last, 1)         as FullName,

      but000.birthdt                                      as DateOfBirth,
      but000.xblck                                        as CentralBlocked,

      // CriticalityCode
      case when but000.xblck = 'X' then 1 //red = 1, green = 3
           else 3
           end                                            as CriticalityCode,

      //User Status
      case when but000.xblck = 'X' then 'User Locked'
           else 'Active'
           end                                            as UserStatus,

      // special logic for attachments
      case when zbp_c_fact_sheet.SecondsCreated > 299
           then cast( '' as abap.char(1) )
           else zbp_c_fact_sheet.CustomerFactSheetUrl end as CustomerFactSheetLink,
      case when zbp_c_fact_sheet.CustomerFactSheetUrl <> '' and zbp_c_fact_sheet.SecondsCreated <= 299
              then zbp_c_fact_sheet.CreatedTimestamp
              else cast( 0 as timestampl ) end            as CustomerFactSheetTimestamp,
      zbp_c_fact_sheet.SecondsCreated                     as SecondsCreated,
      case when zbp_c_fact_sheet.CustomerFactSheetUrl <> '' and zbp_c_fact_sheet.SecondsCreated <= 299
              then cast( 'Download Fact Sheet' as zd42txtdownlfactsh )
              else cast( '' as zd42txtdownlfactsh ) end   as TextDownloadFactSheet,

      _BankDetails,

      _IDNumbers
}

where
  source = 'ZD42'
