*NAME OC-3 (intertag - extinter)
*TIME:24.00
*EXPRESS
*PAGE:999,LIST
*LIBRA:23
*DISC:705/SYSTEM,LCROSS
*FILE:LIB,67
*FILE:MEM,30,W
*PERSO:67
*TAKE TAPE:67
*          *DISC:705/SYSTEM,WORKIN
*          *FILE:LCROSS     - PERSO ACCEMБЛEP+ЗAГPYЗЧИK+ЭMYЛЯTOP
*          *FILE:ASSEM      - OПИCAHИE И TEKCTЫ ACCEMБЛEPA И ЗAГPYЗЧИKA
*          *FILE:EXMEM      - ПAMЯTЬ ДЛЯ MOДYЛEЙ ЗAГPYЗKИ
*          *FILE:EML        - TEKCTЫ ЭMYЛЯTOPA (ЗOHA=1)
*          *FILE:OS         - MAKPOCЫ ( 0 )  И TEKCTЫ  O C  ( 120 )
*CALL FICMEMOR
*NO LIST
*CALL ZMACRO
INTERTAG:NAME QF ; TEГOBCKИE ПPEPЫBAHИЯ
INT10:ENTRY QF
INT11:ENTRY QF
INT12:ENTRY QF
INT13:ENTRY QF
INT19:ENTRY QF
INT20:ENTRY QF
INT21:ENTRY QF
INT22:ENTRY QF
INT23:ENTRY QF
ERROR:SUBP QF
;
GROUP
MODIF
;
IFP
ДД89
;
CMD
;
;                   ПPEPЫBAHИЯ ПPИ ЗAПИCИ B OЗY:
;                   ============================
;
;     21 - ЗAЩИTA AДPECA ПPИ ЗAПИCИ.
;          BOЗHИKAET ПPИ "0" БПTЗ, ECЛИ ПPИ ЗAПИCИ B
;          ПAMЯTЬ CЛOBO ПO ИCП.AДPECY COДEPЖИT "1" B
;          68 PAЗPЯДE TEГA. (CИГHAЛ PWRI ШИHЫ ДAHHЫX).
;
;MOZY=809C2         ;   - INTERTAG
;
INT21:W VTM 1
JMP PROTECT
;
;                  ПPEPЫBAHИЯ ПO TEГY:
;                  ===================
;
;    10 - ПPOГPAMMHAЯ ИHTEPПPETAЦИЯ TEГA KOMAHДЫ.
;         ПPOИCXOДИT BO BPEMЯ BЫБOPKИ KOMAHДHOГO CЛOBA
;         ИЗ OЗY ПPИ "0" БПИHT И "1" 72 PAЗPЯДA TEГA.
;
INT10:RI MTJ IA ; CЧAC => ИAOП
JMP ERROR
;
;    11 - ПPOГPAMMHAЯ ИHTEPПPETAЦИЯ TEГA OПEPAHДA.
;         ПPOИCXOДИT BO BPEMЯ BЫБOPKИ OПEPAHДA ИЗ OЗY
;         ПPИ "0" БПИHT И "1" 72 PAЗPЯДA TEГA OПEPAHДA
INT11:JMP ERROR
;
;    22 - ЧYЖOЙ CYMMATOP.  BOЗHИKAET B OTCYTCTBИE БЧC
;         ПPИ HECOBПAДEHИИ 66 БИTA TEГA TEKYЩEГO KOMA-
;         HДHOГO CЛOBA C ПPИЗHAKOM "PЭ" B  PP.
;
INT22:JMP ERROR
;
;    23 - ЧYЖOЙ OПEPAHД. BOЗHИKAET B OTCYTCTBИE БЧOП
;         ПPИ HECOBПAДEHИИ 66 БИTA TEГA OПEPAHДA C
;         ПPИЗHAKOM "PЭ" B  PP.
;
INT23:JMP ERROR
;
;    12 - ЗAЩИTA AДPECA ПPИ ЧTEHИИ.
;
INT12:W VTM 2
JMP PROTECT
;
;    13 - KOHTPOЛЬ KOMAHДЫ.
;
INT13:JMP ERROR
;
;    19 - ЗAЩИTA BЫБOPKИ KOMAHДЫ.
;
INT19:W VTM 0
RI MTJ IA ; CЧAC ===> ИAOП
;
PROTECT:XTA REGSCAL
JAGE ERROR
AAN 64-61
JAEQ CHM67
W JMNE CHM67
;
;         ДЛЯ ПPOГPAMM, ЗAHИMAЮЩИXCЯ CAMOMOДИФИKAЦИEЙ
;         ДEЛAETCЯ ЗAMEHA KOMAHДЫ "000" HA "075".
;
SETR БЗO+БЗЗ+БПTЗ+БПTЧ+БПИHT
IA XTA
AAX =H0000 0000 BF00 0000
:JANE *+2
IA XTA
AOX =H0000 0000 3D00 0000
IA ATX
:IA XTA
AAX =H00BF 0000 0000 0000
:JANE *+1
UTC =H003D 0000 0000 0000
:XTA
IA AOX
UTY 3
IA TTX
CPUSH
IJP
;
;         ПPOЦECC БЫЛ B "PЭ".  ПPOБA HA ЭKCTPAKOД-67
;
CHM67:
ITA IA ; TKHYЛИCЬ B
W AEX OCT67 ; ЗAЩИTY Э67
JANE ERROR ; - HET
XTA RETM67
JAEQ ERROR
JAGT NOPR67
;         ЗДECЬ - OPГAHИЗAЦИЯ ПEЧATИ
HLT @67
;
NOPR67:XTA RETM67
NG WMOD CЧAC
NG XTA PP
AAX =H0000 0000 E7FF FFFF
NG WMOD PP ; ПИA,ППK = 0
IJP
;
;    20 - ЗAЩИTA ПEPEДAЧИ YПPABЛEHИЯ.
;
INT20:JMP ERROR
;
END
INTERMEM:NAME QF ; CБOИ ПAMЯTИ
;
ERROR:SUBP QF
GROUP
MODIF
CMD
;
;         ПPEPЫBAHИЯ ПPИ OБPAЩEHИИ K OЗY И ШИHE ДAHHЫX
;         ============================================
;
;     2 - MHOГOKPATHAЯ OШИБKA. (CИГHAЛ DERI ШИHЫ).
;     1 - OTCYTCTBYЮЩИЙ БЛOK ПAMЯTИ. (CИГHAЛ AMBI).
;     3 - "TIME-OUT" ПPИ OБPAЩEHИИ K OЗY.
;         BЫPAБATЫBAETCЯ ПPИ OTCYTCTBИИ OTBETA OЗY
;         B TEЧEHИE 100 MИKPOCEKYHД.
;     4 - "TIME-OUT" ПPИ OБPAЩEHИИ K ШИHE.
;         BЫPAБATЫBAETCЯ APБИTPOM ПPИ OTCYTCTBИИ OTBE-
;         TA OT ШИHЫ B TEЧEHИE 100 MИKPOCEKYHД.
;
;     PEГИCTP "PAПY" 0-Й ГPYППЫ ИCПOЛЬЗYETCЯ KAK AДPEC
;     ПEPEXBATA ПPEPЫBAHИЙ ПO OШИБKAM ПAMЯTИ.
;
;MOZY=80981        ;  - INTERMEM
;
:RMOD PAПY
JAEQ ERROR
NG WMOD CЧAC ; AДP.ПEPEXBATA
NG RMOD PP
AAX =H0000 0000 C7FF FFFF
NG WMOD PP ; ГAШ. ПИA,ППK,ППY
UTA ; OTMEHA CЛEД.
WMOD PAПY ; ПEPEXBATA
IJP
;
END
INTERPAG:NAME QF ; CTPAHИЧHЫE ПPEPЫBAHИЯ
FIX_PAGE:ENTRY QF ; ФИKCAЦИЯ ЛИCTA
GIV_PAGE:ENTRY QF ; ЗAЯBKA K SWING
INT8:ENTRY QF
INT15:ENTRY QF
INT16:ENTRY QF
ERROR:ENTRY QF
;
PCW
MAINBLCS:SUBP QF
ACTIVATE:SUBP QF
DESACTIV:SUBP QF
RETURN:SUBP QF
BRANCH1:SUBP QF
KOHCOЛЬ:SUBP QF
DHEX8:SUBP QF
IFP
TPP
PCBIT
PSYS
SPORT
GROUP
EVENT
MODIF
;
CMD
;
;
;                 ПPEPЫBAHИЯ ПO ПPИПИCKE:
;                 =======================
;
;    15 - ЧYЖOЙ PEГИCTP ПPИПИCKИ ПPИ ЧTEHИИ/ЗAПИCИ.
;         BOЗHИKAET ПPИ HECOBПAДEHИИ ПOЛЯ HOMEPA
;         ПPOЦECCA B PEГИCTPE ПPИПИCKИ C HOMEPOM
;         TEKYЩEГO ПPOЦECCA. (ПPИ ПHП=255 CTPAHИЦA
;         ДOCTYПHA BCEM ПPOЦECCAM).
;
;    16 - ЧYЖOЙ PEГИCTP ПPИПИCKИ ПPИ BЫБOPKE KOMAHД.
;         AHAЛOГИЧHO ПPEДЫДYЩEMY.
;
;MOZY=80988     ;   - INTERPAG
;
INT16:RI MTJ IA ; CЧAC => ИAOП
INT15:
SMON БBП
ITA IA
ASFT 10
AAU @3FF
ATI NP ; MAT.ЛИCT
NP QTA TMP<<2
JAEQ ERROR ; ЧYЖOЙ ЛИCT
ATI W
W MSFT 2
AAU 3
JANE PRIVATE
;       ДOCTOBEPHAЯ ИHФOPMAЦИЯ O ПPИПИCKE
;       OБЩИX CTPAHИЦ XPAHИTCЯ B  DTMP !!!
NP QTA DTMP<<2
JAEQ ERROR ; ЧYЖOЙ ЛИCT
ASFT 2
AEI W ; ATPИБYTЫ
AAU @FFFFC ; ЗAЩИTЫ
AEI W ; БEPYTCЯ
ATI W ; ИЗ  TMP !!!
;
PRIVATE:W MTJ J
J MSFT 2
J JMEQ GIV_PAGE
;
;        ЛИCT B ПAMЯTИ.  ЛИБO OH ЗAKPЫT ПO OБMEHY,
;        ЛИБO ПPOCTO Y HAC ЗAБИPAЛИ PEГИCTP ПPИПИCKИ.
;
J HTA TPP<<1
AAU @8000
JAEQ RESTRP
NTA W_EXCH ; ЗAKPЫTИE
TN AOX PCW ; "ПO OБMEHY"
TN ATX PCW
JMP DESACTIV
;
RESTRP:
W MSFT -8
TN J+M W
ITA W
NP WMOD @400
CMON -1
IJP
;
;      BXOД OT ПPEPЫBAHИЙ: OБPAЩEHИE K ПOДKAЧKE.
;      TN - HOMEP ПPOЦECCA, NP - MAT.HOMEP ЛИCTA,
;      BOЗMOЖHO YKPAШEHHЫЙ  FIX- ИЛИ PUSH-БИTAMИ.
;      BHИMAHИE: ПPИ BXOДE OT ЮЗEPA ЧEPEЗ ПPOГPAMMHOE
;      ПPEPЫBAHИE-10 BOЗMOЖEH OTЛYП ПO ЗAHЯTOCTИ
;      ПOДKAЧKИ. TOГДA ЮЗEP ПOЛYЧAET HA CYMMATOPE 0.
;
GIV_PAGE:XTA SWPORT
JAEQ FREE_SW
R VTM MAINBLCS
ITA NP ; OБЫЧHAЯ
AAU @FF000 ; ПOДKAЧKA
JAEQ BL_USER ; -ДA
UTA
NG WMOD ACC ; ЮЗEPY-OTЛYП
NG WMOD ACC+1
JMP RETURN
FREE_SW:ITA TN
ASFT -32
ITS NP
AAX =H0000 0000 FFFF FFFF
15 AOX
ATX SWPORT
NP VTM N_SWING
R VTM ACTIVATE
BL_USER:NTA BL_SEL
TN AOX PCW
TN ATX PCW
R JMP
;
;      BXOД OT ИMEHИ ЮЗEPA: ДEPГAHЬE ЛИCTA И
;      ФИKCAЦИЯ EГO B "TPP" ИЛИ ЗAKPЫTИE ПO OБMEHY.
;        TN - HOMEP ПPOЦECCA
;        NP - MATEMATИЧECKИЙ HOMEP ЛИCTA
;        IA=0, ECЛИ ЗAKPЫTИE.  IA=1, ECЛИ ФИKCAЦИЯ.
;        IA=-1, ECЛИ OTKAЗ OT ЛИCTA.
;        HA BЫXOДE  W=<ФИЗ.HOMEP ЛИCTA>
;
ДEPГAEM:ITA NP
ASFT -10
EXTF 64-20
ATI W
CMON БBП
W XTA @3FF
;
FIX_PAGE:
SMON БBП+БПTЧ+БПИHT
CLRR БЗO+БПHП
NP QTA TMP<<2
ATI W
JAEQ PHYSPAG ; HE ЗAKAЗAH
:AAU 3
JANE PHYSPAG ; ЛИЧHЫЙ ЛИCT
NP QTA DTMP<<2
ATI W ; OБЩИЙ
PHYSPAG:W MSN @400+4
IA JMGE CHFIX
W HTA TPP<<1 ; ПEPEД OTKAЗOM
AAN 64-16 ; HAДO ЖДATЬ
JANE ДEPГAEM ; KOHЦA OБMEHA
NP ATQ TMP<<2
W JMEQ RETFIX ; HE ПPИПИCAH
W HTA TPP<<1
AEI TN
AAU @FF
:JANE *+1
W ATH TPP<<1
:QTA PCNT<<2 +3
A-U 1
ATQ PCNT<<2 +3
JMP RETFIX
;
CHFIX:W JMEQ ДEPГAEM
W HTA TPP<<1
IA AON 64-16 ; + БИT 16 ИЛИ 15
W ATH TPP<<1
;
RETFIX:IA JMGT RET1FIX
NP RMOD @400
AEI TN
AAU @FF
:JANE *+1
NP WMOD @400 ; ГACИM PП
RET1FIX:
CMON БBП+БПTЧ+БПИHT
RETS
;
;       BCЯ CTPAHИЧHAЯ ЗAЩИTA B CИCTEME BEДETCЯ
;       ПO HOMEPY ПPOЦECCA B PEГИCTPAX ПPИПИCKИ.
;       ФAKT ПEPBOГO OБPAЩEHИЯ K CTPAHИЦE PEГИCTPИ-
;       PYETCЯ SWING-OM ПO ЗHAЧEHИЮ ATPИБYTA PR=1
;       (ЗAПИCЬ - PAЗPEШEHA, A ЧTEHИE - HET).
;       TAK ЧTO BCE OCTAЛЬHЫE CTPAHИЧHЫE ПPEPЫBAHИЯ
;       BOЗHИKAЮT B CЛYЧAE OШИБOK.  ПPИ OШИБKAX
;       OPГAHИЗYETCЯ ПPИHYДИTEЛЬHOE BETBЛEHИE.
;
;    17 - ЗAЩИTA CTPAHИЦЫ ПPИ OБPAЩEHИИ. BOЗHИKAET
;         B OTCYTCTBИE БП И БЗO, ECЛИ OПEPAHД KOMAHДЫ
;         ЧTEHИЯ/ЗAПИCИ HAXOДИTCЯ B ЗAЩИЩEHHOЙ CTPAHИ-
;         ЦE ("0" 10-ГO PAЗPЯДA COOTB. PП).    ПPИ
;         BЫБOPKE KOMAHДЫ ЭTOГO ПPEPЫBAHИЯ HE БЫBAET.
;
;    18 - ЗAЩИTA CTPAHИЦЫ ПPИ ЗAПИCИ.  BOЗHИKAET B
;         OTCYTCTBИE БП И БЗЗ И "0" 9-ГO PAЗPЯДA PП.
;
;     8 - OTPИЦATEЛЬHЫЙ HOMEP CTPAHИЦЫ Y KOMAHДЫ.
;         БЛOKИPYETCЯ ПPИЗHAKAMИ БП ИЛИ POA.
;
INT8:RI MTJ IA ; CЧAC => ИAOП
JMP ERROR
;
;     9 - OTPИЦATEЛЬHЫЙ HOMEP CTPAHИЦЫ Y OПEPAHДA.
;
;     7 - OTCYTCTBYЮЩИЙ AДPEC ПAMЯTИ. BOЗHИKAET TOЛЬKO
;         B HOBOM PEЖИME ПPИ HECOBПAДEHИИ 21-32  И 20
;         PAЗPЯДOB MATEMATИЧECKOГO (ИЛИ ФИЗИЧECKOГO,
;         ECЛИ БП) AДPECA OПEPAHДA.
;
; ****   BXOД OT ПPEPЫBAHИЙ: ФATAЛЬHAЯ OШИБKA
;
ERROR:
ITA IA ; И A O П.
ASFT -32
AOI I ; + HOM.OШИБKИ
ATX INFERR
IA VTM E_FAT
TN XTA PCW
AAN P_SYST
JAEQ BRANCH1
I HLT
JMP BRANCH1
;
END
INTERTIM:NAME QF
TCPQUE:ENTRY QF
;*
;***************************************************
;*                                                 *
;*    OБPAБOTKA ПPEPЫBAHИЯ: "ЛOПHYЛ CB-TAЙMEP"     *
;*    BEДEHИE OЧEPEДИ TAЙMEPOB CЧETHOГO BPEMEHИ    *
;*                                                 *
;***************************************************
;*            26.5.88     A.П.CAПOЖHИKOB
;*
;*   B MAШИHE CYЩECTBYET OДИH 64-PAЗPЯДHЫЙ PEГИCTP
;*   CЧETHOГO BPEMEHИ  И OДИH 32-PAЗPЯДHЫЙ TAЙMEP
;*   CЧETHOГO BPEMEHИ ПPOЦECCA.  B TO ЖE BPEMЯ ПPOЦECC
;*   ДOЛЖEH ИMETЬ BOЗMOЖHOCTЬ PAБOTATЬ OДHOBPEMEHHO C
;*   HECKOЛЬKИMИ TAЙMEPAMИ.  BЫXOД COCTOИT B TOM, ЧTO
;*   B ИП ПPOЦECCA BEДETCЯ CПИCOK ЗAKAЗOB HA TAЙMEP,
;*   YПOPЯДOЧEHHЫЙ ПO BOЗPACTAHИЮ BPEMEH CPAБATЫBAHИЯ.
;*   OДИH ЗAKAЗ ЗAHИMAET OДHO 64-PAЗPЯДHOE CЛOBO :
;*      64                          8     1
;*     :----------------------------:-----:
;*     : BPEMЯ CPAБATЫBAHИЯ TAЙMEPA :HOMEP:
;*     :----------------------------:-----:
;*
;*   TCPQUE    -   Прием новой заявки на таймер.
;*   CYMMATOP  = OTHOCИT. BPEMЯ CPAБATЫBAHИЯ TAЙMEPA:
;*   PEГИCTP I = HOMEP TAЙMEPA :
;*
;*   0 - OЧEPEДHOЙ KBAHT CИCTEMЫ PAЗДEЛEHИЯ BPEMEHИ;
;*   1 - ГЛOБAЛЬHЫЙ TIME-LIMIT ПPOЦECCA;
;*   2:N - TAЙMEPЫ, YCTAHABЛИBAEMЫE ЮЗEPOM. ПPИ CPAБA-
;*         TЫBAHИИ TAKOГO TAЙMEPA ПPOЦECCY ГEHEPИPYETCЯ
;*         COБЫTИE.
;*
;*   HAЧAЛЬHOE COCTOЯHИE CПИCKA ЗAKAЗOB YCTAHABЛИBAETCЯ
;*   CИCTEMOЙ ПPИ COЗДAHИИ ПPOЦECCA, ПPИЧEM TAЙMEPЫ 2:N
;*   YCTAHABЛИBAЮTCЯ "HA БECKOHEЧHOCTЬ".
;*   ПPИ ПOCTYПЛEHИИ HOBOГO ЗAKAЗA ПPEДЫДYЩИЙ TAЙMEP C
;*   TEM ЖE HOMEPOM ИЗЫMAETCЯ ИЗ CПИCKA.  TAKИM OБPAЗOM
;*   HA KAЖДЫЙ TAЙMEP ИMEETCЯ POBHO OДHA ЗAЯBKA.
;*   BЫXOД: RR.  ПOPTИTCЯ:J.
;*
;
RETURN:SUBP QF
N:EQU 6 ; ЧИCЛO TAЙMEPOB
MASK:EQU @FF ; ПOЛE "N"
@FF800:BLOCK IFCTIM(6),TQUE
GROUP
MODIF
;
;MOZY=80988      ;   - INTERTIM
;
INTERTIM:
UTA -1
NG WMOD TIMER ; temporary !!!
JMP RETURN
;
TCPQUE:
A+L IFCTIM
ASFT -8
15 ATX ; ЗAЯBKA
J VTM N-1
SEAR:J XTA TQUE ; ПOИCK
AAU MASK ; CTAPOЙ
AEI I ; ЗAЯBKИ
JAEQ TOWN
J VRM SEAR
HLT ; - EE HET !
;---
BACK:J XTA TQUE
J ATX TQUE+1 ; OЧEPEДЬ
TOWN:J VRM BACK ; "ПЯTИTCЯ"
J VTM 2-N
;---
SORT:J XTA TQUE+N-1 ; ПOИCK
J ATX TQUE+N-2 ; MECTA ДЛЯ
15 A-L -1 ; HOBOЙ
JAGT PUT ; ЗAЯBKИ
J VLM SORT
J VTM 1 ; - B CAMЫЙ ЗAД
;---
PUT:15 XTA ; BCTABЛЯEM
AOI I ; HOMEP TAЙMEPA
J ATX TQUE+N-2
XTA TQUE ; HAИMEHЬШИЙ
ASFT 8 ; ИДET B ДEЛO
A-L IFCTIM
NG WMOD TIMER
RR JMP
END
STEPINT:NAME QF
;*
;***      29 -  ШAГOBOE ПPEPЫBAHИE
;*
:HLT 29
IJP ;
END
EXTINTER:NAME QF
PAUSE:ENTRY QF
DELPAUSE:ENTRY QF
;
PROGINT:SUBP QF
INTERTIM:SUBP QF
ACTIVATE:SUBP QF
DESACTIV:SUBP QF
RETURN:SUBP QF
ИЗOЧEP:SUBP QF
PCW
PCBIT
PSYS
SPORT
;
MODIF
;
MIR:EQU @1802 ; Г P П
OБMOЧ
ATQUE:LCB LTQ,ATQ(2)
CDEF
;
CMD
;
;    27 - BHEШHИE ПPEPЫBAHИЯ.
;
;MOZY=8090F      ;   - EXTINTER
;
RMOD MIR
AAX WELL_INT
15 ATX
ANU -1
STI I
I AEN
WMOD MIR ; ГAШEHИE "1"
CPUSH
I NTA
APX WELL_INT
ANU -1
ATI R
SMON БBП+БПTЧ
R JMP *+2
:JMP RETURN ; BAD INT
;
:JMP PROGINT
;
:JMP INTERTIM
;
:I VTM ; ЛOПHYЛ TAЙMEP
JMP ASTIMINT ; ACTP.BPEMEHИ
;
:I VTM 4
JMP BHИMAHИE ; ЗAПPOCЫ OT ПП
:I VTM 3
JMP BHИMAHИE
:I VTM 2
JMP BHИMAHИE
;
ASTIMINT:XTA ATQ
AAU @FF
ATI NP
JAEQ RETURN
;
DEL2:I XTA ATQ+1
I ATX ATQ
I UTM 1
JANE DEL2
XTA LTQ
A-U 1
ATX LTQ
NP XTA PCW
AEN W_AST
NP ATX PCW
XTA ATQ
ATX ASTIMER
A-L CLOCK
JALT ACTIVATE
XTA CLOCK
A-U @100
ATX ASTIMER
JMP ACTIVATE
;
PAUSE:L-A CLOCK
AAU @FFF00
AOI TN
XTS LTQ
ATI I
A+U 1
ATX LTQ
TN XTA PCW
AON W_AST
TN ATX PCW
;
ATSORT:I XTA ATQ
I ATX ATQ+1
15 A-L -1
JALE ATSET
I VRM ATSORT
I VTM -1
;
ATSET:15 XTA
I ATX ATQ+1
XTA ATQ
ATX ASTIMER
JMP DESACTIV
;
DELPAUSE:WTC LTQ
I VTM
DEL1:I XTA ATQ
AEI NP
AAU @FF
JAEQ DEL2
I VRM DEL1
JMP RETURN
;
;           ЗAПPOC OT ПYЛЬTOBOГO ПPOЦECCOPA
;
BHИMAHИE:
RMOD MIR ; ДO BЫЯCHEHИЯ
AAU @FFFF1 ; ГACИM BCE
WMOD MIR ; 3 БИTA
;
XTA PPINF
ASFT 8
JANE NONINPUT
ATX PPINF
NP VTM N_TTAN ; BBOД C
JMP ACTIVATE ; KOHCOЛИ
;
NONINPUT:ATI J ; HOM.ЗAЯBKИ
ASFT -1
ATI W
W XTA JOB-2
W AEX DUBJOB-2
AAX =HFFFF 0000 FFFF FFFF
JANE DPMERR
W XTA JOB-1
W AEX DUBJOB-1
AAX =HFFFF 0000 FFFF FFFF
JANE DPMERR
J UTC -1
J XTA JOB-1
ASFT 48
AAU @FF
ATI CP ; KAHAЛ OБMEHA
A-U 2
CP JALT CHAN01
CP NTA
AOX DDPORT
ATX DDPORT
NP VTM N_DRIV
JMP ACTIVATE
;
CHAN01:R VTM RETURN ; BЫBOД
JMP ИЗOЧEP ; HA KOHCOЛЬ
:J UTC -1
J XTA JOB-1 ; Э071
ASFT 56
ATI NP
NP XTA PCW
AON W_TERM ; "KOHEЦ OБMEHA"
AEN W_TERM
AON IF_FIX ; PACФИKCAЦИЯ
AEN IF_FIX ;   И П
NP ATX PCW
OP_USER:R VTM ACTIVATE
JMP ИЗOЧEP
;
DPMERR:W XTA DUBJOB-2
W HLT
W ATX JOB-2
W XTA DUBJOB-1
W ATX JOB-1
UTA
ATX PPINF
JMP RETURN
END
*END F
