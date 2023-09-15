@AbapCatalog.sqlViewName: 'ZCDX_BP_ID_NUMB'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Business Partner Identification Numbers'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view ZCDX_BP_ID_NUMBERS as select from but0id
    left outer join tb039b as typetx
      on but0id.type = typetx.type
 {
    key partner,
    key but0id.type as type,
    key idnumber,
    valid_date_from,
    valid_date_to,
    
    typetx.text as description
}
where typetx.spras = $session.system_language
