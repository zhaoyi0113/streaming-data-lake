resource "aws_cloudwatch_event_rule" "finance_producer_scheduler" {
  name                = "finance_data_producer_scheduler"
  description         = "Fires every five minutes"
  schedule_expression = "rate(5 minutes)"
  is_enabled          = false
}

resource "aws_cloudwatch_event_target" "fetch_finance_data" {
  rule      = "${aws_cloudwatch_event_rule.finance_producer_scheduler.name}"
  target_id = "finance_producer_cloudwatch"
  arn       = "${aws_lambda_function.finance_data_producer.arn}"
  # input     = "{\"cryptos\": [\"1ST\", \"2GIVE\", \"808\", \"ABT\", \"ABY\", \"AC\", \"ACT\", \"ADA\", \"ADT\", \"ADX\", \"AE\", \"AEON\", \"AGI\", \"AGRS\", \"AI\", \"AID\", \"AION\", \"AIR\", \"AKY\", \"ALIS\", \"AMBER\", \"AMP\", \"ANC\", \"ANT\", \"APPC\", \"APX\", \"ARDR\", \"ARK\", \"ARN\", \"AST\", \"ATB\", \"ATM\", \"ATS\", \"AUR\", \"AVT\", \"B3\", \"BAT\", \"BAY\", \"BBR\", \"BCAP\", \"BCC\", \"BCD\", \"BCH\", \"BCN\", \"BCPT\", \"BCX\", \"BCY\", \"BDL\", \"BEE\", \"BELA\", \"BET\", \"BFT\", \"BIS\", \"BITB\", \"BITBTC\", \"BITCNY\", \"BITEUR\", \"BITGOLD\", \"BITSILVER\", \"BITUSD\", \"BIX\", \"BLITZ\", \"BLK\", \"BLN\", \"BLOCK\", \"BLZ\", \"BMC\", \"BNB\", \"BNT\", \"BNTY\", \"BOST\", \"BOT\", \"BQ\", \"BRD\", \"BRK\", \"BRX\", \"BTA\", \"BTC\", \"BTCD\", \"BTCP\", \"BTG\", \"BTM\", \"BTS\", \"BTSR\", \"BTX\", \"BURST\", \"BUZZ\", \"BYC\", \"BYTOM\", \"C20\", \"CANN\", \"CAT\", \"CCRB\", \"CDT\", \"CFI\", \"CHAT\", \"CHIPS\", \"CLAM\", \"CLOAK\", \"CMP\", \"CMT\", \"CND\", \"CNX\", \"COFI\", \"COSS\", \"COVAL\", \"CRBIT\", \"CREA\", \"CREDO\", \"CRW\", \"CSNO\", \"CTR\", \"CTXC\", \"CURE\", \"CVC\", \"DAI\", \"DAR\", \"DASH\", \"DATA\", \"DAY\", \"DBC\", \"DBIX\", \"DCN\", \"DCR\", \"DCT\", \"DDF\", \"DENT\", \"DFS\", \"DGB\", \"DGC\", \"DGD\", \"DICE\", \"DLT\", \"DMD\", \"DMT\", \"DNT\", \"DOGE\", \"DOPE\", \"DRGN\", \"DTA\", \"DTB\", \"DYN\", \"EAC\", \"EBST\", \"EBTC\", \"ECC\", \"ECN\", \"EDG\", \"EDO\", \"EFL\", \"EGC\", \"EKT\", \"ELA\", \"ELEC\", \"ELF\", \"ELIX\", \"EMB\", \"EMC\", \"EMC2\", \"ENG\", \"ENJ\", \"ENRG\", \"EOS\", \"EOT\", \"EQT\", \"ERC\", \"ETC\", \"ETH\", \"ETHD\", \"ETHOS\", \"ETN\", \"ETP\", \"ETT\", \"EVE\", \"EVX\", \"EXCL\", \"EXP\", \"FCT\", \"FLDC\", \"FLO\", \"FLT\", \"FRST\", \"FTC\", \"FUEL\", \"FUN\", \"GAM\", \"GAME\", \"GAS\", \"GBG\", \"GBX\", \"GBYTE\", \"GCR\", \"GEO\", \"GLD\", \"GNO\", \"GNT\", \"GOLOS\", \"GRC\", \"GRS\", \"GRWI\", \"GTC\", \"GTO\", \"GUP\", \"GVT\", \"GXS\", \"HBN\", \"HEAT\", \"HMQ\", \"HPB\", \"HSR\", \"HUSH\", \"HVN\", \"HXX\", \"ICN\", \"ICX\", \"IFC\", \"IFT\", \"IGNIS\", \"INCNT\", \"IND\", \"INF\", \"INK\", \"INS\", \"INSTAR\", \"INT\", \"INXT\", \"IOC\", \"ION\", \"IOP\", \"IOST\", \"IOTA\", \"IOTX\", \"IQT\", \"ITC\", \"IXC\", \"IXT\", \"J8T\", \"JNT\", \"KCS\", \"KICK\", \"KIN\", \"KMD\", \"KNC\", \"KORE\", \"LBC\", \"LCC\", \"LEND\", \"LEV\", \"LGD\", \"LINDA\", \"LINK\", \"LKK\", \"LMC\", \"LOCI\", \"LOOM\", \"LRC\", \"LSK\", \"LTC\", \"LUN\", \"MAID\", \"MANA\", \"MAX\", \"MBRS\", \"MCAP\", \"MCO\", \"MDA\", \"MEC\", \"MED\", \"MEME\", \"MER\", \"MGC\", \"MGO\", \"MINEX\", \"MINT\", \"MITH\", \"MKR\", \"MLN\", \"MNE\", \"MNX\", \"MOD\", \"MONA\", \"MRT\", \"MSP\", \"MTH\", \"MTN\", \"MUE\", \"MUSIC\", \"MYB\", \"MYST\", \"MZC\", \"NAMO\", \"NANO\", \"NAS\", \"NAV\", \"NBT\", \"NCASH\", \"NDC\", \"NEBL\", \"NEO\", \"NEOS\", \"NET\", \"NLC2\", \"NLG\", \"NMC\", \"NMR\", \"NOBL\", \"NOTE\", \"NPXS\", \"NSR\", \"NTO\", \"NULS\", \"NVC\", \"NXC\", \"NXS\", \"NXT\", \"OAX\", \"OBITS\", \"OCL\", \"OCN\", \"ODEM\", \"ODN\", \"OF\", \"OK\", \"OMG\", \"OMNI\", \"ONION\", \"ONT\", \"OPT\", \"OST\", \"PART\", \"PASC\", \"PAY\", \"PBL\", \"PBT\", \"PFR\", \"PING\", \"PINK\", \"PIVX\", \"PIX\", \"PLBT\", \"PLR\", \"PLU\", \"POA\", \"POE\", \"POLY\", \"POSW\", \"POT\", \"POWR\", \"PPC\", \"PPT\", \"PPY\", \"PRG\", \"PRL\", \"PRO\", \"PST\", \"PTC\", \"PTOY\", \"PURA\", \"QASH\", \"QAU\", \"QLC\", \"QRK\", \"QRL\", \"QSP\", \"QTL\", \"QTUM\", \"QWARK\", \"R\", \"RADS\", \"RAIN\", \"RBIES\", \"RBX\", \"RBY\", \"RCN\", \"RDD\", \"RDN\", \"REC\", \"RED\", \"REP\", \"REQ\", \"RHOC\", \"RIC\", \"RISE\", \"RLC\", \"RLT\", \"RPX\", \"RRT\", \"RUFF\", \"RUP\", \"RVT\", \"SAFEX\", \"SALT\", \"SAN\", \"SBD\", \"SBTC\", \"SC\", \"SEELE\", \"SEQ\", \"SHIFT\", \"SIB\", \"SIGMA\", \"SIGT\", \"SJCX\", \"SKIN\", \"SKY\", \"SLR\", \"SLS\", \"SMART\", \"SMT\", \"SNC\", \"SNGLS\", \"SNM\", \"SNRG\", \"SNT\", \"SOC\", \"SOUL\", \"SPANK\", \"SPC\", \"SPHR\", \"SPR\", \"SRN\", \"START\", \"STEEM\", \"STK\", \"STORJ\", \"STORM\", \"STQ\", \"STRAT\", \"STX\", \"SUB\", \"SWFTC\", \"SWIFT\", \"SWT\", \"SYNX\", \"SYS\", \"TAAS\", \"TAU\", \"TCC\", \"TFL\", \"THC\", \"THETA\", \"TIME\", \"TIX\", \"TKN\", \"TKR\", \"TKS\", \"TNB\", \"TNT\", \"TOA\", \"TRAC\", \"TRC\", \"TRCT\", \"TRIG\", \"TRST\", \"TRUE\", \"TRUST\", \"TRX\", \"TUSD\", \"TX\", \"UBQ\", \"UKG\", \"ULA\", \"UNB\", \"UNITY\", \"UNO\", \"UNY\", \"UP\", \"URO\", \"USDT\", \"UTK\", \"VEE\", \"VEN\", \"VERI\", \"VIA\", \"VIB\", \"VIBE\", \"VIVO\", \"VOISE\", \"VOX\", \"VPN\", \"VRC\", \"VRM\", \"VRS\", \"VSL\", \"VTC\", \"VTR\", \"WABI\", \"WAN\", \"WAVES\", \"WAX\", \"WCT\", \"WDC\", \"WGO\", \"WGR\", \"WINGS\", \"WPR\", \"WTC\", \"WTT\", \"XAS\", \"XAUR\", \"XBC\", \"XBY\", \"XCN\", \"XCP\", \"XDN\", \"XEL\", \"XEM\", \"XID\", \"XLM\", \"XMG\", \"XMR\", \"XMT\", \"XMY\", \"XPM\", \"XRL\", \"XRP\", \"XSPEC\", \"XST\", \"XTZ\", \"XUC\", \"XVC\", \"XVG\", \"XWC\", \"XZC\", \"XZR\", \"YEE\", \"YOYOW\", \"ZCC\", \"ZCL\", \"ZCO\", \"ZEC\", \"ZEN\", \"ZET\", \"ZIL\", \"ZLA\", \"ZRX\"]}"
  input = "{\"cryptos\": [\"BTC\", \"XRP\"]}"
}

resource "aws_cloudwatch_event_rule" "crawler_state_change" {
  name        = "finance_glue_crawler_state_change"
  description = "Capture Glue Crawler complete"

  event_pattern = <<PATTERN
{
  "detail-type": [
        "Glue Crawler State Change"
    ],
    "source": [
        "aws.glue"
    ]
}
PATTERN
}

resource "aws_cloudwatch_event_target" "raw_crawler_state_change_to_sqs" {
  rule      = "${aws_cloudwatch_event_rule.crawler_state_change.name}"
  target_id = "SendToSQS"
  arn = "${aws_sqs_queue.finance_streaming_queue.arn}"
}