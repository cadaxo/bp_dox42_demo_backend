@AbapCatalog.sqlViewName: 'ZCDX_BP_BANK_DE'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Business Partner Bank Details'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view ZCDX_BP_BANK_DETAILS as select from but0bk {
    key partner,
    key bkvid,
    banks,
    bankl,
    bankn,
    iban
}
