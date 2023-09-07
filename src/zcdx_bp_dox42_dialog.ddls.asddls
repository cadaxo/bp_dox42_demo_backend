@EndUserText.label: 'Abstract entity to extend the validity'
@Metadata.allowExtensions: true
define abstract entity zcdx_bp_dox42_dialog 
 // with parameters parameter_name : parameter_type 
  {
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZCDX_BP_DOX42_TEMPLATES', element: 'TemplateId' } }]
    @EndUserText.label: 'Select Template:'
    template_id : zcdx_dox42_templateid;
    
}
