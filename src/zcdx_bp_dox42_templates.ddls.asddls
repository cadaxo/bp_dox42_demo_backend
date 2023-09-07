@AbapCatalog.sqlViewName: 'ZCDX_BP_DOX42_T'
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Business Partner dox42 templates'
@ObjectModel.resultSet.sizeCategory: #XS
define view  ZCDX_BP_DOX42_TEMPLATES as select from zcdx_dox42_templ {
    @EndUserText.label: 'Select Template:'
    @UI.lineItem: [{label: 'Test' }]
    key template_id as TemplateId,
    template_desc as TemplateDesc
}
