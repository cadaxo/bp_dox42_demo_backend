@AbapCatalog.sqlViewName: 'ZCDXBPD42TBBNDET'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'bankdetails'
define view ZCDX_BP_DOX42_TAB_BANK_DETAILS as select from but0bk
left outer join bnka
    on but0bk.banks = bnka.banks
    and but0bk.bankl = bnka.bankl
{
    key bnka.banks as Banks,
    key bnka.bankl as Bankl,
    key but0bk.partner as Partner,
    key but0bk.bkvid as Bkvid,
    bnka.erdat as Erdat,
    bnka.ernam as Ernam,
    bnka.banka as Banka,
    bnka.provz as Provz,
    bnka.stras as Stras,
    bnka.ort01 as Ort01,
    bnka.swift as Swift,
    bnka.bgrup as Bgrup,
    bnka.xpgro as Xpgro,
    bnka.loevm as Loevm,
    bnka.bnklz as Bnklz,
    bnka.pskto as Pskto,
    bnka.adrnr as Adrnr,
    bnka.brnch as Brnch,
    bnka.chkme as Chkme,
    bnka.vers as Vers,
    bnka.iban_rule as IbanRule,
    bnka.sdd_b2b as SddB2b,
    bnka.sdd_cor1 as SddCor1,
    bnka.sdd_rtrans as SddRtrans,
    but0bk.bankn as Bankn,
    but0bk.bkont as Bkont,
    but0bk.bkref as Bkref,
    but0bk.koinh as Koinh,
    but0bk.bkext as Bkext,
    but0bk.xezer as Xezer,
    but0bk.accname as Accname,
    but0bk.move_bkvid as MoveBkvid,
    but0bk.protect as Protect,
    but0bk.bk_valid_from as BkValidFrom,
    but0bk.bk_valid_to as BkValidTo,
    but0bk.bk_move_date as BkMoveDate,
    but0bk.iban as Iban,
    but0bk.bank_guid as BankGuid,
    but0bk.account_id as AccountId,
    but0bk.check_digit as CheckDigit,
    but0bk.account_type as AccountType,
    but0bk.bp_eew_but0bk as BpEewBut0bk
}
