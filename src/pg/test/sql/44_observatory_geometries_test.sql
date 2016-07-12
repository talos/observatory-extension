\pset format unaligned
\set ECHO all

-- set up variables for use in testing

\set cartodb_census_tract_geometry '0106000020E6100000010000000103000000010000003500000056EF703B347C52C054FF2092215B44401B9AB2D30F7C52C03FE1ECD6325B4440B14B546F0D7C52C0BBCE86FC335B4440730F09DFFB7B52C0B796C9703C5B4440108FC4CBD37B52C0B96C74CE4F5B444001C0B167CF7B52C0ED0BE8853B5B4440C843DFDDCA7B52C05DDDB1D8265B4440A73D25E7C47B52C0D53BDC0E0D5B4440BB5E9A22C07B52C0F8A3A833F75A4440355F251FBB7B52C0B64604E3E05A444008910C39B67B52C098BF42E6CA5A44405227A089B07B52C0F204C24EB15A444024F1F274AE7B52C069E4F38AA75A44402B4A09C1AA7B52C06B63EC84975A4440E199D024B17B52C0546F0D6C955A44403C873254C57B52C02EAC1BEF8E5A44402593533BC37B52C0588AE42B815A4440973AC8EBC17B52C087890629785A44407A6F0C01C07B52C0E1EB6B5D6A5A44401B9B1DA9BE7B52C03F6F2A52615A444088855AD3BC7B52C088669E5C535A4440E1EA0088BB7B52C0E6E95C514A5A44400CE6AF90B97B52C070D05E7D3C5A44401E85EB51B87B52C0B03A72A4335A4440BAF3C473B67B52C09929ADBF255A4440CD920035B57B52C0454AB3791C5A4440F78DAF3DB37B52C0E09BA6CF0E5A4440DBC2F352B17B52C0703FE081015A444015C440D7BE7B52C05E83BEF4F659444041446ADAC57B52C0EFDFBC38F15944405FB1868BDC7B52C0C03E3A75E559444034BC5983F77B52C0205ED72FD8594440EFFCA204FD7B52C07E384888F25944403ACAC16C027C52C00876FC17085A444056478E74067C52C00FECF82F105A44400FECF82F107C52C0876D8B321B5A4440BB438A01127C52C0DE1CAED51E5A4440B9C15087157C52C034643C4A255A444099F221A81A7C52C0D0EFFB372F5A44404AED45B41D7C52C0785DBF60375A4440373465A71F7C52C065A71FD4455A4440C558A65F227C52C0D80DDB16655A4440F92EA52E197C52C09BA73AE4665A4440DEE522BE137C52C00664AF777F5A44405698BED7107C52C04759BF99985A444012D90759167C52C09430D3F6AF5A444044679945287C52C01F680586AC5A444049F086342A7C52C09CC3B5DAC35A44401FF5D72B2C7C52C0CB811E6ADB5A4440247EC51A2E7C52C0548B8862F25A4440FF59F3E32F7C52C0CB290131095B4440F96871C6307C52C09605137F145B444056EF703B347C52C054FF2092215B4440'

\set cartodb_county_geometry '0106000020E610000001000000010300000001000000930200005051F52B9D8352C042B28009DC50444093C2BCC7998352C0E89E758D965144402EFD4B52998352C09A07B0C8AF514440E75086AA988352C022FAB5F5D351444027874F3A918352C0A46B26DF6C53444018E945ED7E8352C04D81CCCEA25344401346B3B27D8352C05D50DF32A753444068226C787A8352C08D25AC8DB153444015C8EC2C7A8352C004560E2DB2534440DF8618AF798352C00FD07D39B3534440FEB627486C8352C0DC9E20B1DD534440B98C9B1A688352C05D328E91EC5344408B8A389D648352C0929048DBF853444075CAA31B618352C0986A662D05544440EA758BC0588352C0D6C397892254444048DFA469508352C0151DC9E53F544440B67F65A5498352C0F73DEAAF575444401403249A408352C05E2A36E6755444402367614F3B8352C06DE2E47E8754444011FC6F253B8352C0431B800D885444403E7958A8358352C0DD0A6135965444401D739EB12F8352C093DFA293A5544440FB04508C2C8352C035289A07B05444401EA4A7C8218352C0347F4C6BD3544440D7C05609168352C05053CBD6FA544440AC8E1CE90C8352C0C9AA083719554440FC8D76DCF08252C0BD18CA897655444048895DDBDB8252C0C3B7B06EBC554440698995D1C88252C032207BBDFB55444004A73E90BC8252C0DB4C857824564440BC1FB75F3E8252C08F368E588B574440E15D2EE23B8252C066F4A3E194574440C614AC71368252C0381268B0A9574440CEA44DD53D8152C04F1F813FFC564440A51133FB3C8152C0F607CA6DFB56444070D05E7D3C8152C0CB0C1B65FD564440C5C6BC8E388152C0F303577902574440EA043411368152C03F390A1005574440840B7904378152C0D34ECDE506574440390A1005338152C047E350BF0B5744405D143DF0318152C0D53BDC0E0D5744401D59F965308152C00A4966F50E574440236420CF2E8152C00FD253E41057444084EE92382B8152C0AD2D3C2F15574440E23D0796238152C0A304FD851E574440B3EDB435228152C001D9EBDD1F5744401EBE4C14218152C08BDCD3D51D574440A2D0B2EE1F8152C0FC1BB4571F57444007B0C8AF1F8152C0CC9717601F574440F678211D1E8152C0374E0AF31E5744401A69A9BC1D8152C0793D98141F574440102384471B8152C0CB2F833122574440B7EEE6A90E8152C09F1D705D315744405968E7340B8152C02C0E677E355744400E4A9869FB8052C0C91EA166485744401B2C9CA4F98052C05C001AA54B5744401AF8510DFB8052C0C51A2E724F574440925CFE43FA8052C0309DD66D50574440BB9866BAD78052C0035DFB027A574440A04FE449D28052C02920ED7F80574440DC9BDF30D18052C0E8305F5E80574440B43C0FEECE8052C0D8614CFA7B5744404AEEB089CC8052C0950A2AAA7E5744409A5B21ACC68052C032FE7DC6855744406682E15CC38052C01EF7ADD689574440F78DAF3DB38052C020CD58349D5744402FFA0AD28C8052C00919C8B3CB574440D0251C7A8B8052C00EA2B5A2CD57444001DE02098A8052C030444E5FCF5744404A404CC2858052C0992A1895D45744403480B740828052C0A33CF372D857444028ECA2E8818052C0CD0358E4D7574440F3AACE6A818052C074ECA012D75744402920ED7F808052C0DFA293A5D657444036E84B6F7F8052C092054CE0D6574440AD4CF8A57E8052C0E55FCB2BD757444042CA4FAA7D8052C01AA19FA9D7574440A2EC2DE57C8052C0205ED72FD8574440BB6246787B8052C08BE07F2BD95744405C74B2D47A8052C025E7C41EDA5744405CA8FC6B798052C0F52EDE8FDB574440FF0758AB768052C09AAF928FDD574440A60A4625758052C0C442AD69DE574440A73E90BC738052C05E49F25CDF574440BF9A0304738052C046ED7E15E0574440A19BFD81728052C070B4E386DF5744403D0AD7A3708052C0D0F0660DDE574440680586AC6E8052C04D469561DC57444063963D096C8052C0965AEF37DA574440944E24986A8052C0BA641C23D957444059501894698052C014B01D8CD8574440E21FB6F4688052C0614D6551D85744401895D409688052C0205ED72FD85744406379573D608052C0A4A487A1D55744401878EE3D5C8052C041B5C189E85744402F4FE78A528052C0A580B4FF01584440983270404B8052C0EECEDA6D1758444050357A35408052C0E3C281902C58444086C43D963E8052C0DC9DB5DB2E584440C5E061DA378052C0BFF2203D455844409946938B318052C0C4E9245B5D5844407C478D09318052C040A374E95F584440E3A8DC442D8052C0F92AF9D85D584440919C4CDC2A8052C06BD26D895C584440276893C3278052C0E9279CDD5A58444053B131AF238052C061C092AB5858444055336B29208052C068E55E605658444091990B5C1E8052C082C64CA25E584440AA2688BA0F8052C027F6D03E56584440F488D1730B8052C0D21C59F9655844400C1CD0D2158052C0BB96900F7A584440C6A69542208052C0B77BB94F8E584440D3A23EC91D8052C02EC901BB9A584440B6BDDD921C8052C0BF42E6CAA058444082E49D43198052C036902E36AD58444072FBE593158052C0ACA92C0ABB5844402B4F20EC148052C0EC3026FDBD584440E4BCFF8F138052C04E266E15C4584440C26856B60F8052C06E15C440D7584440C404357C0B8052C00F5EBBB4E1584440397CD289048052C0CA87A06AF4584440FB761211FE7F52C090F7AA9509594440D93C0E83F97F52C03561FBC9185944402828452BF77F52C0F06DFAB31F594440F9BD4D7FF67F52C0DC9A745B225944403AADDBA0F67F52C0BE4D7FF62359444093C49272F77F52C0526342CC25594440450DA661F87F52C0798EC87729594440F2CCCB61F77F52C0067FBF982D5944409B030473F47F52C017821C94305944401E300F99F27F52C05609168733594440E57FF277EF7F52C0EDBAB72231594440A3AA09A2EE7F52C0EA1ED95C355944405D18E945ED7F52C0D3F6AFAC345944401C5DA5BBEB7F52C076DB85E63A5944404BADF71BED7F52C0B1D991EA3B5944401F477364E57F52C0E48409A35959444022179CC1DF7F52C001D8800871594440A4703D0AD77F52C02EC6C03A8E594440457F68E6C97F52C061C26856B659444070404B57B07F52C0FCDEA63FFB594440DC10E335AF7F52C048E00F3FFF59444055F7C8E6AA7F52C02DB4739A055A4440A4E2FF8EA87F52C00CFFE9060A5A44407E8AE3C0AB7F52C0EC4960730E5A444006F2ECF2AD7F52C08CD99255115A444042588D25AC7F52C09BA8A5B9155A44405A9A5B21AC7F52C0F4BF5C8B165A44406762BA10AB7F52C0A5BA8097195A4440E5B7E864A97F52C0B6BDDD921C5A44402B4A09C1AA7F52C0499F56D11F5A4440D48041D2A77F52C0177FDB13245A4440C22FF5F3A67F52C0D55B035B255A4440FE7BF0DAA57F52C0F8FD9B17275A44409A046F48A37F52C04FADBEBA2A5A444045F12A6B9B7F52C0AC1919E42E5A44404BE2AC889A7F52C0A75CE15D2E5A4440462575029A7F52C0965984622B5A4440E75086AA987F52C0906802452C5A44400B2769FE987F52C05FB01BB62D5A444004029D499B7F52C0DD2230D6375A44404301DBC1887F52C0CBF10A444F5A4440D6A88768747F52C0B81E85EB515A44407C0C569C6A7F52C0F6CFD380415A4440CB113290677F52C0A9328CBB415A44407905A227657F52C03D7C9928425A44407EA5F3E1597F52C0787AA52C435A444009F7CABC557F52C0A2410A9E425A44408D23D6E2537F52C00EF8FC30425A444029780AB9527F52C08B19E1ED415A44402992AF04527F52C08B19E1ED415A4440C51A2E724F7F52C08B19E1ED415A4440AC36FFAF3A7F52C01AA6B6D4415A444009522976347F52C0A2410A9E425A4440F25D4A5D327F52C0252026E1425A44408252B4722F7F52C05A61FA5E435A444032E202D0287F52C013B534B7425A4440E0BBCD1B277F52C014E97E4E415A44409352D0ED257F52C0151DC9E53F5A444022F94A20257F52C0B08BA2073E5A4440CF9ECBD4247F52C0F3AE7AC03C5A444077A1B94E237F52C0F3AE7AC03C5A4440DDB419A7217F52C097FBE428405A4440666A12BC217F52C016A243E0485A44408EACFC32187F52C0CD8DE9094B5A44404F05DCF3FC7E52C0B952CF82505A4440D2E0B6B6F07E52C0FFCA4A93525A44404F029B73F07E52C0A7E7DD58505A4440EA3C2AFEEF7E52C020B41EBE4C5A44404A5F0839EF7E52C01AF7E6374C5A4440D462F030ED7E52C055F5F23B4D5A4440825660C8EA7E52C0B5FD2B2B4D5A4440825660C8EA7E52C072DA53724E5A44403C2CD49AE67E52C030B77BB94F5A44400DDC813AE57E52C0D76B7A50505A4440670DDE57E57E52C0072461DF4E5A4440C77DAB75E27E52C0A25EF0694E5A4440ABB2EF8AE07E52C04F04711E4E5A44403A3FC571E07E52C03C65355D4F5A4440643A747ADE7E52C04ED026874F5A444077F35487DC7E52C08A027D224F5A4440F0A5F0A0D97E52C031EBC5504E5A444068588CBAD67E52C0D8D30E7F4D5A444046B3B27DC87E52C06FB9FAB1495A4440B85A272EC77E52C03C821B295B5A444039CE6DC2BD7E52C097016729595A44409A07B0C8AF7E52C07FD93D79585A44407E8AE3C0AB7E52C0EBC37AA3565A4440C1E10511A97E52C0D097DEFE5C5A44401B82E3326E7E52C03F170D198F5A44408A3C49BA667E52C0D619DF17975A444026DF6C73637E52C07A32FFE89B5A4440E78BBD175F7E52C000FE2955A25A4440594DD7135D7E52C040852348A55A4440E36A64575A7E52C03EE94482A95A4440E603029D497E52C067B62BF4C15A4440ED42739D467E52C04701A260C65A4440253ACB2C427E52C03E40F7E5CC5A4440D026874F3A7E52C061C5A9D6C25A44405C5837DE1D7E52C0868F8829915A4440162EABB0197E52C007B5DFDA895A4440B859BC58187E52C083A279008B5A44408FE046CA167E52C011FB04508C5A4440B131AF230E7E52C0D2C43BC0935A44401A4CC3F0117E52C0F0FACC599F5A44401A321EA5127E52C06631B1F9B85A44402B836A83137E52C0E55C8AABCA5A4440C9737D1F0E7E52C0B376DB85E65A4440D3687231067E52C07405DB88275B444009DE9046057E52C09A94826E2F5B4440158C4AEA047E52C08D7E349C325B4440C808A870047E52C0B6114F76335B4440634337FB037E52C00F290648345B4440DAA7E331037E52C03E7958A8355B444082902C60027E52C0DE3CD521375B4440AB5791D1017E52C048BF7D1D385B4440942F6821017E52C095287B4B395B4440268C6665FB7D52C0548A1D8D435B44405C1B2AC6F97D52C065187783685B4440FA0B3D62F47D52C03FE08101845B4440E2E313B2F37D52C03196E997885B444038F4160FEF7D52C05D50DF32A75B4440109546CCEC7D52C07FDB1324B65B44401C261AA4E07D52C0BA641C23D95B444076BF0AF0DD7D52C06AF7AB00DF5B4440DCB8C5FCDC7D52C0B06F2711E15B44405A0EF450DB7D52C0081F4AB4E45B444084D558C2DA7D52C0F57F0EF3E55B4440BBB20B06D77D52C06E693524EE5B4440CE6BEC12D57D52C0FB592C45F25B444073672618CE7D52C09A0645F3005C4440BB7B80EECB7D52C0C7BAB88D065C4440F5F411F8C37D52C057E9EE3A1B5C44407B8670CCB27D52C09AB4A9BA475C4440240B98C0AD7D52C0282A1BD6545C4440E4839ECDAA7D52C0FA5E43705C5C4440E4805D4D9E7D52C08AAA5FE97C5C44401B2AC6F99B7D52C01C2444F9825C4440D3122BA3917D52C059F8FA5A975C4440A7ACA6EB897D52C0FD2D01F8A75C444007B5DFDA897D52C04818062CB95C44401EF7ADD6897D52C0399A232BBF5C444036397CD2897D52C0904946CEC25C444001DE02098A7D52C08A58C4B0C35C4440CB68E4F38A7D52C0527B116DC75C4440AD4F39268B7D52C0AB92C83EC85C4440531EDD088B7D52C0EB19C231CB5C4440C5C551B9897D52C070EB6E9EEA5C444090847D3B897D52C02E5393E00D5D44409C4CDC2A887D52C01D39D219185D4440FC6EBA65877D52C00D87A5811F5D4440D9CC21A9857D52C0641F6459305D44402D7590D7837D52C0DB4FC6F8305D44409354A698837D52C03FE1ECD6325D44402D5BEB8B847D52C05CC64D0D345D44403A3DEFC6827D52C02C0E677E355D44405299620E827D52C0938C9C853D5D444011AAD4EC817D52C0CE8AA8893E5D44407689EAAD817D52C045BB0A293F5D444094A2957B817D52C02C5F97E13F5D4440EDED96E4807D52C060048D99445D44407C7A6CCB807D52C00551F701485D4440BE69FAEC807D52C0999A046F485D44401781B1BE817D52C0ECF483BA485D444028ECA2E8817D52C0F6D214014E5D44403480B740827D52C07024D060535D4440BD35B055827D52C0CEF8BEB8545D44401C3EE944827D52C03F389F3A565D4440FF243E77827D52C0B534B742585D44407B2C7DE8827D52C02AFD84B35B5D44406F7EC344837D52C0535C55F65D5D4440DA006C40847D52C041F163CC5D5D4440459DB987847D52C0CE15A584605D4440FDBCA948857D52C0F4A44C6A685D44408658FD11867D52C097A608707A5D44404FAF9465887D52C03EC91D36915D4440BD38F1D58E7D52C0CFF753E3A55D44406876DD5B917D52C0F1B6D26BB35D44405B7A34D5937D52C0E4F1B4FCC05D4440B6476FB88F7D52C0C0E78711C25D4440743E3C4B907D52C0A5BBEB6CC85D4440D190F128957D52C03A394371C75D4440ADA06989957D52C0512D228AC95D4440D74D29AF957D52C01BB80375CA5D4440307F85CC957D52C0E542E55FCB5D444042EA76F6957D52C049D40B3ECD5D444054556820967D52C0B3226AA2CF5D44408F6D1970967D52C0C189E8D7D65D4440AD6C1FF2967D52C0F71BEDB8E15D4440BED7101C977D52C0C8B4368DED5D4440D47D00529B7D52C0EBE1CB44115E44403F00A94D9C7D52C068774831405E4440F7393E5A9C7D52C04339D1AE425E44409831056B9C7D52C090A2CEDC435E4440984BAAB69B7D52C02384471B475E4440A547533D997D52C04ED026874F5E44403F170D198F7D52C00E661360585E4440545227A0897D52C0E202D0285D5E4440D3139678407D52C026A435069D5E44406C753925207D52C0CA54C1A8A45E44403B1BF2CF0C7D52C0E17CEA58A55E4440FD12F1D6F97C52C078962023A05E444068C9E369F97C52C0A81ABD1AA05E44406FBA6587F87C52C037A79201A05E44407008556AF67C52C0CC24EA059F5E44404CE141B3EB7C52C0F3FE3F4E985E444003CE52B29C7C52C06C239EEC665E44409AB33EE5987C52C020EEEA55645E4440DFC0E446917C52C0CF6394675E5E444014200A664C7C52C07F315BB22A5E44401D8D43FD2E7C52C0D71533C2DB5D4440C4758C2B2E7C52C09C4B7155D95D4440EE08A7052F7C52C0444B1E4FCB5D444091B6F1272A7C52C0A7069ACFB95D444014C95702297C52C0CC785BE9B55D4440807F4A95287C52C0567C43E1B35D44407405DB88277C52C0A0C4E74EB05D44400057B263237C52C07E39B35DA15D4440AC8BDB68007C52C0AB90F2936A5D444025E4839ECD7B52C0395E81E8495D444018265305A37B52C0C2DCEEE53E5D44402781CD39787B52C0685721E5275D4440514832AB777B52C0639AE95E275D4440F2599E07777B52C0EC6987BF265D4440F94A2025767B52C0B16B7BBB255D44409485AFAF757B52C088D860E1245D4440893F8A3A737B52C09622F94A205D44408D0C7217617B52C0BF5E61C1FD5C444026C286A7577B52C0D3DA34B6D75C4440FCDD3B6A4C7B52C0D0967329AE5C444030630AD6387B52C082C64CA25E5C444081E7DEC3257B52C0A33B889D295C4440639AE95E277B52C0D47FD6FCF85B44407EC34483147B52C03A394371C75B4440342A70B20D7B52C0D826158DB55B444099EFE0270E7B52C06762BA10AB5B4440D3F36E2C287B52C0350873BB975B4440D427B9C3267B52C07842AF3F895B4440C4245CC8237B52C030D7A205685B4440880CAB78237B52C08B8A389D645B4440902E36AD147B52C0718C648F505B4440AF928FDD057B52C05169C4CC3E5B44407E8978EBFC7A52C0FC1BB4571F5B44409DF0129CFA7A52C05D86FF74035B4440DCD8EC48F57A52C044A51133FB5A444027BD6F7CED7A52C0D769A4A5F25A44406B9C4D47007B52C0E4F4F57CCD5A4440F29881CAF87A52C095D233BDC45A44403F19E3C3EC7A52C05BEB8B84B65A44403468E89FE07A52C0DF14562AA85A4440E0F08288D47A52C0224F92AE995A44403448C153C87A52C0B8E34D7E8B5A44401155F833BC7A52C06C91B41B7D5A44401DE6CB0BB07A52C050C3B7B06E5A444029779FE3A37A52C0A568E55E605A44400584D6C3977A52C0889AE8F3515A44401215AA9B8B7A52C0DD3F16A2435A4440EE21E17B7F7A52C0C1711937355A4440B3EC4960737A52C0E692AAED265A4440D7BFEB33677A52C0CAC4AD82185A4440E350BF0B5B7A52C04EEE77280A5A4440CE18E6046D7A52C001FA7DFFE6594440DAA9B9DC607A52C0B5A7E49CD8594440B7B6F0BC547A52C0DAC87553CA594440DB899290487A52C0ED7E15E0BB594440CB0EF10F5B7A52C0239D819197594440A25EF0694E7A52C0B340BB438A594440BBEB6CC83F7A52C092E9D0E9795944407F68E6C9357A52C033C4B12E6E594440205D6C5A297A52C05DA27A6B605944401B834E081D7A52C065AA605452594440765089EB187A52C0A27895B54D5944402A357BA0157A52C07B4D0F0A4A5944408A5759DB147A52C0F2B1BB404959444097530262127A52C0D0436D1B465944409E5E29CB107A52C0ADA1D45E445944400A630B410E7A52C07F85CC9541594440DB12B9E00C7A52C00F46EC134059444000378B170B7A52C039419B1C3E5944408A20CEC3097A52C06AF981AB3C59444080423D7D047A52C0670C738236594440CAA48636007A52C034677DCA31594440BF44BC75FE7952C0A051BAF42F594440605628D2FD7952C077BE9F1A2F59444093AAED26F87952C0DF87838428594440CFF6E80DF77952C033164D672759444011346612F57952C07C2AA73D2559444001310917F27952C0E8482EFF21594440730CC85EEF7952C05567B5C01E594440984A3FE1EC7952C0B6D782DE1B5944404CE141B3EB7952C0570394861A594440C91CCBBBEA7952C00B9A9658195944408E1EBFB7E97952C08EACFC3218594440A794D74AE87952C08FE046CA165944409677D503E67952C0B41EBE4C145944402EC55565DF7952C0E2E995B20C5944408F52094FE87952C09DF0129CFA58444052EC681CEA7952C06326512FF8584440E02D90A0F87952C0739EB12FD9584440519E7939EC7952C05C8DEC4ACB584440938AC6DADF7952C0A5846055BD5844401666A19DD37952C07C08AA46AF58444029CE5147C77952C0B3942C27A1584440B2666490BB7952C0AEEE586C935844404E232D95B77952C0EDF0D7648D584440A4198BA6B37952C0FC6EBA65875844401E34BBEEAD7952C0179B560A81584440A297512CB77952C0289831056B5844400DE02D90A07952C0B3D0CE6916584440789961A3AC7952C0A6D1E4620C58444076FEEDB25F7952C015713AC956574440D50627A25F7952C06072A3C85A574440E7A562635E7952C0E08096AE6057444012876C205D7952C05AD2510E6657444072C3EFA65B7952C0C4EC65DB69574440FCC6D79E597952C0374D9F1D7057444051D7DAFB547952C0554FE61F7D574440658D7A88467952C04F1DAB949E57444008556AF6407952C04A7D59DAA95744406F9C14E63D7952C0A5811FD5B0574440A679C7293A7952C09CC0745AB757444061FBC9181F7952C097A608707A574440B0C91AF5107952C03483F8C08E5744402E36AD14027952C0718BF9B9A1574440D4997B48F87852C089D00836AE574440BBD23252EF7852C090BB085394574440EF8E8CD5E67852C01840F850A2574440EACE13CFD97852C0B6847CD0B35744408C48145AD67852C09012BBB6B7574440E690D442C97852C084B53176C257444063F030ED9B7852C090BA9D7DE5574440DFC0E446917852C0DEE2E13D075844403FFD67CD8F7852C0719010E50B5844401C2785798F7852C0764D486B0C584440B1BE81C98D7852C093FE5E0A0F58444037363B527D7852C0093543AA28584440C3D50110777852C09355116E32584440EEE714E4677852C03387A4164A584440717500C45D7852C07EA5F3E1595844407442E8A04B7852C0E108522976584440211CB3EC497852C0CE35CCD0785844405791D101497852C09D7DE5417A584440CB660E492D7852C0056A3178985844401AC1C6F5EF7752C0B9162D40DB5844400F7C0C569C7752C03EE8D9ACFA584440AC1E300F997752C0828AAA5FE9584440A661F888987752C0C2A38D23D6584440DCBC7152987752C042959A3DD0584440A661F888987752C0302AA913D0584440E7FF55478E7752C05DC2A1B7785844402FFA0AD28C7752C0581CCEFC6A584440DCB930D28B7752C021567F8461584440FB20CB82897752C062D7F6764B58444079909E22877752C0D89942E7355844408C63247B847752C0B58993FB1D584440ACE46377817752C0677E350708584440C6C210397D7752C0B2F4A10BEA57444074B680D07A7752C0909DB7B1D9574440DB317557767752C0077767EDB65744409A7631CD747752C02D7B12D89C5744400D6C9560717752C054FEB5BC72574440FC34EECD6F7752C0A3E6ABE4635744409E7AA4C16D7752C0D1949D7E50574440FE9C82FC6C7752C0E046CA16495744401E4FCB0F5C7752C09B53C90050574440D503E621537752C0E063B0E25457444037DC476E4D7752C032569BFF5757444070ED4449487752C0836C59BE2E57444066F50EB7437752C054C554FA0957444032022A1C417752C0713C9F01F55644404487C091407752C01F7EFE7BF05644406E4E2503407752C05D4C33DDEB56444088F546AD307752C03ECBF3E0EE5644401F0F7D772B7752C04835ECF7C4564440A33B889D297752C026AAB706B656444087A4164A267752C0938E72309B5644403B6F63B3237752C050FD834886564440D7F7E120217752C00D6C956071564440132A38BC207752C07A8A1C226E564440315D88D51F7752C07E8E8F1667564440D4F02DAC1B7752C0ADA415DF505644409E95B4E21B7752C09AE8F35146564440B88D06F0167752C0BB46CB811E564440A435069D107752C0C8E88024EC554440C9703C9F017752C0F01307D0EF55444083DE1B43007752C0855D143DF05544404EB4AB90F27652C0A69718CBF45544401ABE8575E37652C0C214E5D2F855444041649126DE7652C0FACE2F4AD0554440293C6876DD7652C0807D74EACA554440FAD170CADC7652C0779FE3A3C55544403FABCC94D67652C0F58079C8945544405AD76839D07652C0B41D537765554440849ECDAACF7652C0272D5C56615544405DA79196CA7652C0D87F9D9B36554440331477BCC97652C06A10E6762F55444060AB048BC37652C062F20698F95444402D23F59ECA7652C05D6919A9F754444011C30E63D27652C0B8E864A9F554444021C9ACDEE17652C073D87DC7F0544440F0F96184F07652C06FB72407EC5444408577B988EF7652C0DFA5D425E3544440A089B0E1E97652C0C8091346B35444403621AD31E87652C0999CDA19A6544440C763062AE37652C0EF3B86C77E5444401F4AB4E4F17652C0E0D4079277544440E2E65432007752C054E4107173544440FF0241800C7752C061FA5E437054444057B26323107752C0F677B6476F5444402026E1421E7752C00FEB8D5A61544440834F73F2227752C0E3361AC05B544440C2F693313E7752C0C05AB56B4254444097900F7A367752C0780C8FFD2C544440F834272F327752C06684B70721544440C4758C2B2E7752C03D0801F9125444408D959867257752C00E4A9869FB534440E68F696D1A7752C02FF99FFCDD53444022C2BF081A7752C0247F30F0DC534440EF1CCA50157752C03599F1B6D2534440C0B2D2A4147752C06551D845D15344409048DBF8137752C09509BFD4CF53444014419C87137752C0FB027AE1CE534440E5F04927127752C01A84B9DDCB53444092B06F27117752C0DAC87553CA5344407EA65EB7087752C0228C9FC6BD534440A3E4D539067752C065170CAEB9534440C2FA3F87F97652C059F5B9DA8A5344408BFA2477D87652C082A62556465344406403E962D37652C03197546D3753444018B49080D17652C0D5928E72305344404A22FB20CB7652C0765089EB185344402A1900AAB87652C0BE0F070951524440E386DF4DB77652C01F63EE5A425244400F7D772B4B7652C005A568E55E524440FB3F87F9F27552C07D224F92AE5144405793A7ACA67552C0D7C0560916514440BEDA519CA37552C0A44FABE80F514440745B22179C7552C0E2CCAFE600514440DCD6169E977552C00B43E4F4F5504440A93121E6927552C05E807D74EA504440D13FC1C58A7552C056ED9A90D6504440096B63EC847552C0AB92C83EC8504440AE80423D7D7552C04127840EBA50444040F7E5CC767552C0D0967329AE50444089CE328B507552C0162D40DB6A504440C8ED974F567552C05646239F57504440211FF46C567552C03674B33F5050444015713AC9567552C059DC7F643A5044404AB20E47577552C028B682A62550444037AB3E575B7552C0F7AE415F7A4F44408D261763607552C0226C787AA54E444045460724617552C0A94885B1854E4440F62686E4647552C02D978DCEF94D444036AE7FD7677552C018AE0E80B84D4440B9E00CFE7E7552C0B01F6283854D4440446B459BE37552C0C5E23785954C444012A27C410B7652C03C1405FA444C4440588B4F01307652C0B058C345EE4B4440A6457D923B7652C07C28D192C74B44402C9CA4F9637652C0A2957B81594B4440A81ABD1AA07652C0300C5872154B4440FBC8AD49B77652C035272F32014B44404127840EBA7652C02AE109BDFE4A44401DCBBBEA017752C02172FA7ABE4A4440130CE71A667752C0C6A2E9EC644A44400A4B3CA06C7752C0BEF8A23D5E4A4440A5D93C0E837752C06473D53C474A4440FDBCA948857752C06B98A1F1444A4440F0C000C2877752C0F0DE5163424A4440D8817346947752C04450357A354A4440BF28417FA17752C08099EFE0274A44400A2DEBFEB17752C0BCAE5FB01B4A44407FF8F9EFC17752C08C0DDDEC0F4A444053C90050C57752C0B14B546F0D4A44402E71E481C87752C0BF61A2410A4A44401EFB592C457852C09F39EB538E494440056D72F8A47852C06D8E739B7049444036AD1402B97852C0D68BA19C68494440F59F353FFE7852C0BAA0BE654E494440289A07B0C87952C0C58F31772D4944406133C005D97952C0D862B7CF2A494440E1783E03EA7952C04DDA54DD2349444046B3B27DC87A52C06A11514CDE4844402F185C73477B52C0FCE25295B6484440A26131EA5A7B52C06A696E85B04844408499B67F657B52C036902E36AD4844404F8F6D19707B52C0C1C760C5A94844402E1D739EB17B52C02BDCF29194484440F9122A38BC7B52C0B5132521914844401021AE9CBD7B52C080D250A39048444081CEA44DD57B52C0431B800D88484440BBB88D06F07B52C076A38FF980484440B5A50EF27A7C52C07780272D5C484440F7C77BD5CA7C52C08AE5965643484440614D6551D87C52C05CFDD8243F484440E84CDA54DD7C52C03F1878EE3D4844409947FE60E07C52C05774EB353D484440AF0793E2E37C52C0FF5C34643C48444065A54929E87C52C0C45E28603B484440EFAB72A1F27C52C01F12BEF737484440D07D39B35D7D52C0075F984C1548444025AB22DC647D52C03D0801F912484440C39E76F86B7D52C0861C5BCF104844401211FE45D07F52C0F2CEA10C55474440B804E09F528252C0785C548B884644407615527E528252C0DB85E63A8D464440E2E5E95C518252C0BB270F0BB546444089B48D3F518252C0A7203F1BB94644400858AB764D8252C0F294D5743D474440CD565EF23F8252C07D7555A0164944401B28F04E3E8252C0E9F010C64F494440AAB4C5353E8252C0BDC117265349444032CB9E04368252C0F6285C8FC24944405111A7936C8252C09FE238F06A4B44402252D32EA68252C0BC02D193324D44404C50C3B7B08252C0F9F36DC1524D444068075C57CC8252C0ECDCB419A74D4440A31F0DA7CC8252C086E3F90CA84D44409D2E8B89CD8252C0438CD7BCAA4D44402BA1BB24CE8252C00726378AAC4D4440DDE9CE13CF8252C035423F53AF4D4440A774B0FECF8252C0C266800BB24D4440A626C11BD28252C007431D56B84D4440EDD286C3D28252C0DC476E4DBA4D44402638F581E48252C04A5F0839EF4D444074779D0DF98252C0E3C281902C4E4440890629780A8352C016DC0F78604E44408315A75A0B8352C0E5EFDE51634E4440EA793716148352C036E84B6F7F4E44404703780B248352C0C24CDBBFB24E44403046240A2D8352C09BE09BA6CF4E4440A4C00298328352C02D776682E14E444055F833BC598352C09F91088D604F4440B3B27DC85B8352C08922A46E674F444075E789E76C8352C066118AADA04F44400D52F014728352C051F355F2B14F4440C5ABAC6D8A8352C0D4D00660035044403D7E6FD39F8352C05C1ABFF04A5044405051F52B9D8352C042B28009DC504440'

-- OBS_GetBoundary tests

-- expect most recent census tract boundary at cartodb nyc
-- timespan implictly null
SELECT cdb_observatory.OBS_GetBoundary(
  cdb_observatory._TestPoint(),
  'us.census.tiger.census_tract'
) = :'cartodb_census_tract_geometry' As OBS_GetBoundary_cartodb_census_tract;

-- expect most recent census county boundary (brooklyn) at cartodb nyc
-- timespan implictly null
SELECT cdb_observatory.OBS_GetBoundary(
  cdb_observatory._TestPoint(),
  'us.census.tiger.county'
) = :'cartodb_county_geometry' As OBS_GetBoundary_cartodb_county;

-- expect null geometry since boundary_id is null
-- timespan implictly null
SELECT cdb_observatory.OBS_GetBoundary(
  cdb_observatory._TestPoint(),
  'us.census.tiger.non_existent'
) IS NULL As OBS_GetBoundary_non_existent_boundary_id;

-- expect null geometry since there are no census tracts at null island
-- timespan implictly null
SELECT cdb_observatory.OBS_GetBoundary(
  CDB_LatLng(0, 0),
  'us.census.tiger.census_tract'
) IS NULL As OBS_GetBoundary_null_island_census_tract;

-- expect census tract boundary at cartodb nyc from 2014
SELECT cdb_observatory.OBS_GetBoundary(
  cdb_observatory._TestPoint(),
  'us.census.tiger.census_tract',
  '2014'
) = :'cartodb_census_tract_geometry' As OBS_GetBoundary_year_census_tract;

-- should return null
-- look for census tracts a year before census released them
SELECT cdb_observatory.OBS_GetBoundary(
  cdb_observatory._TestPoint(),
  'us.census.tiger.census_tract',
  '1988'
) IS NULL As OBS_GetBoundary_unlisted_year;

-- OBS_GetBoundaryId tests

-- should give back '36047048500', the geoid of cartodb's census tract
SELECT cdb_observatory.OBS_GetBoundaryId(
  cdb_observatory._TestPoint(),
  'us.census.tiger.census_tract'
) = '36047048500'::text As OBS_GetBoundaryId_cartodb_census_tract;

-- should give back '36047048500', the geoid of cartodb's census tract
SELECT cdb_observatory.OBS_GetBoundaryId(
  cdb_observatory._TestPoint(),
  'us.census.tiger.census_tract',
  '2014'
) = '36047048500'::text As OBS_GetBoundaryId_cartodb_census_tract_with_year;

-- should give back '36047', the geoid of cartodb's county (King's/
--  Brooklyn, NY)
SELECT cdb_observatory.OBS_GetBoundaryId(
  cdb_observatory._TestPoint(),
  'us.census.tiger.county',
  '2014'
) = '36047'::text As OBS_GetBoundaryId_cartodb_county_with_year;

-- should give back null since there is not a census tract at null island
SELECT cdb_observatory.OBS_GetBoundaryId(
  CDB_LatLng(0, 0),
  'us.census.tiger.census_tract'
) IS NULL As OBS_GetBoundaryId_null_island;

-- OBS_GetBoundaryById

-- should give geometry of King's County/Brooklyn, NY

SELECT cdb_observatory.OBS_GetBoundaryById(
  '36047',
  'us.census.tiger.county'
) = :'cartodb_county_geometry' As OBS_GetBoundaryById_cartodb_county;

-- Should match output of GetBoundary on similar inputs
SELECT cdb_observatory.OBS_GetBoundaryById(
  '36047', -- cartodb's county
  'us.census.tiger.county'
) = cdb_observatory.OBS_GetBoundary(
  cdb_observatory._TestPoint(), -- CartoDB's office
  'us.census.tiger.county'
) As OBS_GetBoundaryById_compared_with_obs_GetBoundary;

-- should give null since boundary_id does not match geometry reference id
SELECT cdb_observatory.OBS_GetBoundaryById(
  '36047',
  'us.census.tiger.county',
  '2014'
) = :'cartodb_county_geometry' OBS_GetBoundaryById_boundary_id_mismatch_geom_id;

-- should give null since boundary_id does not match geometry reference id
SELECT cdb_observatory.OBS_GetBoundaryById(
  '36047',
  'us.census.tiger.census_tract'
) IS NULL As OBS_GetBoundaryById_boundary_id_mismatch_geom_id;

-- _OBS_GetBoundariesByGeometry

-- check that all census tracts intersecting with the geometry are returned
-- order them to ensure that the same values are returned
SELECT
  array_agg(geom_refs) = Array['36047025700','36047028501','36047038900','36047039100','36047042300','36047042500','36047042700','36047044900','36047045300','36047048500','36047048900','36047049100','36047049300','36047050500','36047050700'] As _OBS_GetBoundariesByGeometry_tracts_around_cartodb
FROM (
  SELECT *
  FROM cdb_observatory._OBS_GetBoundariesByGeometry(
    -- near CartoDB's office
    ST_MakeEnvelope(-73.9452409744,40.6988851644,-73.9280319214,40.7101254524,
                    4326),
    'us.census.tiger.census_tract')
  ORDER BY geom_refs ASC
) As m(the_geom, geom_refs);

-- Null Island area
SELECT
  array_length(array_agg(geom_refs), 1) IS NULL As _OBS_GetBoundariesByGeometry_tracts_around_null_island
FROM (
  SELECT *
  FROM cdb_observatory._OBS_GetBoundariesByGeometry(
    -- around null island
    ST_MakeEnvelope(-0.1400756836,-0.2114863362,0.1455688477,0.2059932086,
                    4326),
    'us.census.tiger.census_tract')
  ORDER BY geom_refs ASC
) As m(the_geom, geom_refs);

-- OBS_GetBoundariesByGeometry

-- check that all census tracts intersecting with the geometry are returned
-- order them to ensure that the same values are returned
SELECT
  array_agg(geom_refs) = Array['36047025700','36047028501','36047038900','36047039100','36047042300','36047042500','36047042700','36047044900','36047045300','36047048500','36047048900','36047049100','36047049300','36047050500','36047050700'] As OBS_GetBoundariesByGeometry_tracts_around_cartodb
FROM (
  SELECT *
  FROM cdb_observatory.OBS_GetBoundariesByGeometry(
    -- near CartoDB's office
    ST_MakeEnvelope(-73.9452409744,40.6988851644,-73.9280319214,40.7101254524,
                    4326),
    'us.census.tiger.census_tract')
  ORDER BY geom_refs ASC
) As m(the_geom, geom_refs);

-- Null Island area
SELECT
  array_length(array_agg(geom_refs), 1) IS NULL As OBS_GetBoundariesByGeometry_tracts_around_null_island
FROM (
  SELECT *
  FROM cdb_observatory.OBS_GetBoundariesByGeometry(
    -- around null island
    ST_MakeEnvelope(-0.1400756836,-0.2114863362,0.1455688477,0.2059932086,
                    4326),
    'us.census.tiger.census_tract')
  ORDER BY geom_refs ASC
) As m(the_geom, geom_refs);

-- who's on first boundaries
SELECT
  array_agg(geom_refs) = Array['85632785','85633051','85633111','85633147','85633253','85633267'] As OBS_GetBoundariesByGeometry_wof
FROM (
  SELECT *
  FROM cdb_observatory.OBS_GetBoundariesByGeometry(
    ST_MakeEnvelope(-4.66, 40.43, 14.48, 51.99, 4326),
    'whosonfirst.wof_country_geom')
  ORDER BY geom_refs ASC
) As m(the_geom, geom_refs);

-- OBS_GetBoundariesByPointAndRadius

-- check that all census tracts intersecting with the geometry are returned
-- order them to ensure that the same values are returned
SELECT
  array_agg(geom_refs) = Array['36047038900','36047039100','36047042500','36047042700','36047045300','36047048500','36047048900','36047049100','36047049300'] As OBS_GetBoundariesByPointAndRadius_around_cartodb
FROM (
  SELECT *
  FROM cdb_observatory.OBS_GetBoundariesByPointAndRadius(
    -- 500 meter circle centered on CartoDB's office
    cdb_observatory._testPoint(),
    500,
    'us.census.tiger.census_tract')
  ORDER BY geom_refs ASC
) As m(the_geom, geom_refs);

-- Null Island area
SELECT
  array_length(array_agg(geom_refs), 1) IS NULL As OBS_GetBoundariesByPointAndRadius_around_null_island
FROM (
  SELECT *
  FROM cdb_observatory.OBS_GetBoundariesByPointAndRadius(
    -- around null island
    ST_SetSRID(ST_Point(0, 0), 4326),
    500,
    'us.census.tiger.census_tract')
  ORDER BY geom_refs ASC
) As m(the_geom, geom_refs);

-- _OBS_GetPointsByGeometry

-- check that all census tracts intersecting with the geometry are returned
-- order them to ensure that the same values are returned
SELECT
  array_agg(geom_refs) = Array['36047025700','36047028501','36047038900','36047039100','36047042300','36047042500','36047042700','36047044900','36047045300','36047048500','36047048900','36047049100','36047049300','36047050500','36047050700'] As _OBS_GetPointsByGeometry_around_cartodb
FROM (
  SELECT *
  FROM cdb_observatory._OBS_GetPointsByGeometry(
    -- around CartoDB's Brooklyn office
    ST_MakeEnvelope(-73.9452409744,40.6988851644,
                    -73.9280319214,40.7101254524,
                    4326),
    'us.census.tiger.census_tract')
  ORDER BY geom_refs ASC
) As m(the_geom, geom_refs);

-- Null Island area
SELECT
  array_length(array_agg(geom_refs), 1) IS NULL As _OBS_GetPointsByGeometry_around_null_island
FROM (
  SELECT *
  FROM cdb_observatory._OBS_GetPointsByGeometry(
    -- around null island
    ST_MakeEnvelope(-0.1400756836,-0.2114863362,
                     0.1455688477, 0.2059932086,
                    4326),
    'us.census.tiger.census_tract')
  ORDER BY geom_refs ASC
) As m(the_geom, geom_refs);


-- OBS_GetPointsByGeometry

-- check that all census tracts intersecting with the geometry are returned
-- order them to ensure that the same values are returned
SELECT
  array_agg(geom_refs) = Array['36047025700','36047028501','36047038900','36047039100','36047042300','36047042500','36047042700','36047044900','36047045300','36047048500','36047048900','36047049100','36047049300','36047050500','36047050700'] As OBS_GetPointsByGeometry_around_cartodb
FROM (
  SELECT *
  FROM cdb_observatory.OBS_GetBoundariesByGeometry(
    -- around CartoDB's Brooklyn office
    ST_MakeEnvelope(-73.9452409744,40.6988851644,
                    -73.9280319214,40.7101254524,
                    4326),
    'us.census.tiger.census_tract')
  ORDER BY geom_refs ASC
) As m(the_geom, geom_refs);

SELECT
  array_agg(geom_refs) = Array['36047025700','36047028501','36047038900','36047039100','36047042300','36047042500','36047042700','36047044900','36047045300','36047048500','36047048900','36047049100','36047049300','36047050500','36047050700'] As OBS_GetPointsByGeometry_around_cartodb_2014
FROM (
  SELECT *
  FROM cdb_observatory.OBS_GetBoundariesByGeometry(
    -- around CartoDB's Brooklyn office
    ST_MakeEnvelope(-73.9452409744,40.6988851644,
                    -73.9280319214,40.7101254524,
                    4326),
    'us.census.tiger.census_tract',
    '2014')
  ORDER BY geom_refs ASC
) As m(the_geom, geom_refs);

-- Null Island area
SELECT
  array_length(array_agg(geom_refs), 1) IS NULL As OBS_GetPointsByGeometry_around_null_island
FROM (
  SELECT *
  FROM cdb_observatory.OBS_GetBoundariesByGeometry(
    -- around null island
    ST_MakeEnvelope(-0.1400756836,-0.2114863362,
                     0.1455688477, 0.2059932086,
                    4326),
    'us.census.tiger.census_tract')
  ORDER BY geom_refs ASC
) As m(the_geom, geom_refs);

-- OBS_GetPointsByPointAndRadius

-- check that all census tracts intersecting with the geometry are returned
-- order them to ensure that the same values are returned
SELECT
  array_agg(geom_refs) = Array['36047038900','36047039100','36047042500','36047042700','36047045300','36047048500','36047048900','36047049100','36047049300'] As OBS_GetPointsByPointAndRadius_around_cartodb
FROM (
  SELECT *
  FROM cdb_observatory.OBS_GetPointsByPointAndRadius(
    -- around CartoDB's Brooklyn office
    cdb_observatory._testpoint(),
    500,
    'us.census.tiger.census_tract')
  ORDER BY geom_refs ASC
) As m(the_geom, geom_refs);

SELECT
  array_agg(geom_refs) = Array['36047038900','36047039100','36047042500','36047042700','36047045300','36047048500','36047048900','36047049100','36047049300'] As OBS_GetPointsByPointAndRadius_around_cartodb_2014
FROM (
  SELECT *
  FROM cdb_observatory.OBS_GetPointsByPointAndRadius(
    -- around CartoDB's Brooklyn office
    cdb_observatory._testpoint(),
    500,
    'us.census.tiger.census_tract',
    '2014')
  ORDER BY geom_refs ASC
) As m(the_geom, geom_refs);

-- Null Island area
SELECT
  array_length(array_agg(geom_refs), 1) IS NULL As OBS_GetPointsByPointAndRadius_around_null_island
FROM (
  SELECT *
  FROM cdb_observatory.OBS_GetPointsByPointAndRadius(
    -- around null island
    ST_SetSRID(ST_Point(0, 0), 4326),
    500,
    'us.census.tiger.census_tract')
  ORDER BY geom_refs ASC
) As m(the_geom, geom_refs);

-- _OBS_GetGeometryMetadata
-- get metadata for census tracts

SELECT
  geoid_colname = 'geoid' As geoid_name_matches,
  target_table = 'obs_fc050f0b8673cfe3c6aa1040f749eb40975691b7' As table_name_matches,
  geom_colname = 'the_geom' As geom_name_matches
FROM cdb_observatory._OBS_GetGeometryMetadata('us.census.tiger.census_tract')
     As m(geoid_colname, target_table, geom_colname);

-- get metadata for boundaries with clipped geometries
 SELECT
   geoid_colname = 'geoid' As geoid_name_matches,
   target_table = 'obs_fcd4e4f5610f6764973ef8c0c215b2e80bec8963' As table_name_matches,
   geom_colname = 'the_geom' As geom_name_matches
 FROM cdb_observatory._OBS_GetGeometryMetadata('us.census.tiger.census_tract_clipped') As m(geoid_colname, target_table, geom_colname);

\i test/fixtures/drop_fixtures.sql
