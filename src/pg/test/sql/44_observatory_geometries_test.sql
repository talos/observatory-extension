\i test/sql/load_fixtures.sql
\pset format unaligned

-- set up variables for use in testing

\set cartodb_census_tract_geometry '0106000020E6100000010000000103000000010000003500000056EF703B347C52C054FF2092215B44401B9AB2D30F7C52C03FE1ECD6325B4440B14B546F0D7C52C0BBCE86FC335B4440730F09DFFB7B52C0B796C9703C5B4440108FC4CBD37B52C0B96C74CE4F5B444001C0B167CF7B52C0ED0BE8853B5B4440C843DFDDCA7B52C05DDDB1D8265B4440A73D25E7C47B52C0D53BDC0E0D5B4440BB5E9A22C07B52C0F8A3A833F75A4440355F251FBB7B52C0B64604E3E05A444008910C39B67B52C098BF42E6CA5A44405227A089B07B52C0F204C24EB15A444024F1F274AE7B52C069E4F38AA75A44402B4A09C1AA7B52C06B63EC84975A4440E199D024B17B52C0546F0D6C955A44403C873254C57B52C02EAC1BEF8E5A44402593533BC37B52C0588AE42B815A4440973AC8EBC17B52C087890629785A44407A6F0C01C07B52C0E1EB6B5D6A5A44401B9B1DA9BE7B52C03F6F2A52615A444088855AD3BC7B52C088669E5C535A4440E1EA0088BB7B52C0E6E95C514A5A44400CE6AF90B97B52C070D05E7D3C5A44401E85EB51B87B52C0B03A72A4335A4440BAF3C473B67B52C09929ADBF255A4440CD920035B57B52C0454AB3791C5A4440F78DAF3DB37B52C0E09BA6CF0E5A4440DBC2F352B17B52C0703FE081015A444015C440D7BE7B52C05E83BEF4F659444041446ADAC57B52C0EFDFBC38F15944405FB1868BDC7B52C0C03E3A75E559444034BC5983F77B52C0205ED72FD8594440EFFCA204FD7B52C07E384888F25944403ACAC16C027C52C00876FC17085A444056478E74067C52C00FECF82F105A44400FECF82F107C52C0876D8B321B5A4440BB438A01127C52C0DE1CAED51E5A4440B9C15087157C52C034643C4A255A444099F221A81A7C52C0D0EFFB372F5A44404AED45B41D7C52C0785DBF60375A4440373465A71F7C52C065A71FD4455A4440C558A65F227C52C0D80DDB16655A4440F92EA52E197C52C09BA73AE4665A4440DEE522BE137C52C00664AF777F5A44405698BED7107C52C04759BF99985A444012D90759167C52C09430D3F6AF5A444044679945287C52C01F680586AC5A444049F086342A7C52C09CC3B5DAC35A44401FF5D72B2C7C52C0CB811E6ADB5A4440247EC51A2E7C52C0548B8862F25A4440FF59F3E32F7C52C0CB290131095B4440F96871C6307C52C09605137F145B444056EF703B347C52C054FF2092215B4440'

\set cartodb_county_geometry '0106000020E6100000010000000103000000010000002C0200005051F52B9D8352C042B28009DC50444093C2BCC7998352C0E89E758D965144402EFD4B52998352C09A07B0C8AF514440E75086AA988352C022FAB5F5D351444027874F3A918352C0A46B26DF6C53444018E945ED7E8352C04D81CCCEA25344401346B3B27D8352C05D50DF32A753444068226C787A8352C08D25AC8DB153444015C8EC2C7A8352C004560E2DB2534440DF8618AF798352C00FD07D39B3534440FEB627486C8352C0DC9E20B1DD534440B98C9B1A688352C05D328E91EC5344408B8A389D648352C0929048DBF853444075CAA31B618352C0986A662D05544440EA758BC0588352C0D6C397892254444048DFA469508352C0151DC9E53F544440B67F65A5498352C0F73DEAAF575444401403249A408352C05E2A36E6755444402367614F3B8352C06DE2E47E8754444011FC6F253B8352C0431B800D885444403E7958A8358352C0DD0A6135965444401D739EB12F8352C093DFA293A5544440FB04508C2C8352C035289A07B05444401EA4A7C8218352C0347F4C6BD3544440D7C05609168352C05053CBD6FA544440AC8E1CE90C8352C0C9AA083719554440FC8D76DCF08252C0BD18CA897655444048895DDBDB8252C0C3B7B06EBC554440698995D1C88252C032207BBDFB55444004A73E90BC8252C0DB4C857824564440321F10E84C8252C08862F20698574440BB0853944B8252C09831056B9C57444080F0A1444B8252C0D32F116F9D574440C7629B54348252C0418177F2E9574440CEA44DD53D8152C04F1F813FFC564440A51133FB3C8152C0F607CA6DFB5644404D2EC6C03A8152C0DD43C2F7FE564440C5C6BC8E388152C0F3035779025744404B3E7617288152C0C1340C1F11574440C99063EB198152C0BB6070CD1D57444086E5CFB7058152C001D9EBDD1F574440DD770C8FFD8052C09F573CF548574440E69315C3D58052C0BCE47FF2775744404852D2C3D08052C0122C0E677E574440581EA4A7C88052C084F068E388574440187AC4E8B98052C0336C94F59B5744400E828E56B58052C0A80018CFA0574440B7B24467998052C0C8409E5DBE574440BEA085048C8052C032ACE28DCC5744401215AA9B8B8052C0A8A8FA95CE574440B9313D61898052C01F2A8D98D9574440C6DFF604898052C0A8C5E061DA574440AA622AFD848052C0B5F81400E3574440BD1B0B0A838052C012656F29E75744406C91B41B7D8052C0745AB741ED5744408C2C9963798052C0D2FA5B02F05744403315E291788052C079AF5A99F0574440412B3064758052C0128255F5F25744401329CDE6718052C0B7CEBF5DF6574440FEB3E6C75F8052C00876FC1708584440B70721205F8052C04374081C09584440A7CD380D518052C0C00303081F5844400133DFC14F8052C001BF469220584440EA211ADD418052C07570B03731584440CD3CB9A6408052C015342DB13258444020B1DD3D408052C0B03A72A433584440BA66F2CD368052C09F3D97A9495844400EDB1665368052C08C9E5BE84A584440F3AB3940308052C05376FA415D584440880FECF82F8052C0115322895E584440C6DD205A2B8052C0DC7F643A74584440FC389A232B8052C0F4A78DEA74584440990F0874268052C0FDD64E9484584440A5BDC117268052C02C27A1F4855844407218CC5F218052C0F9BB77D498584440F65E7CD11E8052C0E8A1B60DA3584440C1374D9F1D8052C0BC3E73D6A758444022DC6454198052C00629780AB95844406519E258178052C0FF03AC55BB584440FA5FAE450B8052C05704FF5BC9584440D7A3703D0A8052C0F25B74B2D458444036ACA92C0A8052C00A849D62D55844407FDAA84E078052C006BAF605F45844408B8862F2068052C017F19D98F558444006F1811DFF7F52C04DBD6E111859444048FAB48AFE7F52C0CF6740BD195944407A1A3048FA7F52C0E6AC4F3926594440382BA226FA7F52C08D614ED0265944407A34D593F97F52C0081B9E5E29594440F8A3A833F77F52C03A58FFE7305944402AAA7EA5F37F52C0643C4A253C594440A7E507AEF27F52C0321CCF674059444063EFC517ED7F52C0438D429259594440B1A6B228EC7F52C0185E49F25C5944400DC2DCEEE57F52C09BAA7B6473594440EA059FE6E47F52C0C3D50110775944403B8DB454DE7F52C059F5B9DA8A594440A06CCA15DE7F52C094F3C5DE8B5944408509A359D97F52C0910C39B69E594440244223D8B87F52C0FE7A8505F7594440EF004F5AB87F52C08DD31055F85944409CDA19A6B67F52C03F53AF5B045A4440F7730AF2B37F52C05A9C31CC095A444009C21550A87F52C0077C7E18215A44409E3F6D54A77F52C00C056C07235A4440C3499A3FA67F52C0586E6935245A44407020240B987F52C080B6D5AC335A4440DDD0949D7E7F52C07383A10E2B5A44404E417E36727F52C0207A5226355A4440F4A44C6A687F52C0A2410A9E425A4440E92ADD5D677F52C061527C7C425A44407905A227657F52C03D7C9928425A4440791C06F3577F52C0D9EA724A405A4440F2B4FCC0557F52C08690F3FE3F5A4440FE7C5BB0547F52C0209738F2405A444052F17F47547F52C014E97E4E415A4440350C1F11537F52C0AF230ED9405A444098158A743F7F52C08F519E79395A44401ABD1AA0347F52C0A3586E69355A4440EB5223F4337F52C0207A5226355A4440A8AAD0402C7F52C0D89942E7355A44407C5EF1D4237F52C0613596B0365A44400227DBC01D7F52C007EA9447375A4440567E198C117F52C084D72E6D385A44402C7DE882FA7E52C0249BABE6395A4440D72FD80DDB7E52C0955F0663445A44401F2A8D98D97E52C0CBA0DAE0445A4440ACC612D6C67E52C0771211FE455A444026FBE769C07E52C06B64575A465A44400B7BDAE1AF7E52C023D5777E515A44407E8AE3C0AB7E52C0EBC37AA3565A4440268DD13AAA7E52C04F55A181585A4440525F96766A7E52C02502D53F885A4440A69C2FF65E7E52C003B16CE6905A44403B342C465D7E52C0D8B5BDDD925A444002B859BC587E52C0B20FB22C985A4440B0912408577E52C0871403249A5A444039950C00557E52C021E7FD7F9C5A4440D3139678407E52C015731074B45A444080ED60C43E7E52C0BAF3C473B65A4440FB3BDBA3377E52C074CC79C6BE5A44401BB7989F1B7E52C042E73576895A4440B01A4B581B7E52C03D2AFEEF885A4440D68C0C72177E52C07C60C77F815A44407EA99F37157E52C0AE80423D7D5A444053910A630B7E52C04A2366F6795A4440B7EEE6A90E7E52C0670E492D945A44401A4CC3F0117E52C0D829560DC25A444064AE0CAA0D7E52C0D74CBED9E65A4440D3687231067E52C07405DB88275B4440158C4AEA047E52C08D7E349C325B4440AB5791D1017E52C048BF7D1D385B4440268C6665FB7D52C0548A1D8D435B44405C1B2AC6F97D52C065187783685B4440FA0B3D62F47D52C03FE08101845B4440E2E313B2F37D52C03196E997885B444038F4160FEF7D52C05D50DF32A75B4440109546CCEC7D52C07FDB1324B65B44401C261AA4E07D52C0BA641C23D95B44405A0EF450DB7D52C0081F4AB4E45B4440BBB20B06D77D52C06E693524EE5B4440CE6BEC12D57D52C0FB592C45F25B444073672618CE7D52C09A0645F3005C4440BB7B80EECB7D52C0C7BAB88D065C4440F5F411F8C37D52C057E9EE3A1B5C44407B8670CCB27D52C09AB4A9BA475C4440240B98C0AD7D52C0282A1BD6545C4440E4839ECDAA7D52C0FA5E43705C5C4440E4805D4D9E7D52C08AAA5FE97C5C44401B2AC6F99B7D52C01C2444F9825C4440D3122BA3917D52C059F8FA5A975C4440A7ACA6EB897D52C0FD2D01F8A75C444007B5DFDA897D52C04818062CB95C44401EF7ADD6897D52C0399A232BBF5C444036397CD2897D52C0904946CEC25C444001DE02098A7D52C08A58C4B0C35C4440CB68E4F38A7D52C0527B116DC75C4440AD4F39268B7D52C0AB92C83EC85C4440531EDD088B7D52C0EB19C231CB5C4440C5C551B9897D52C070EB6E9EEA5C444077F4BF5C8B7D52C090149161155D44409BE447FC8A7D52C0161406651A5D4440D13FC1C58A7D52C0F792C6681D5D4440E3DEFC86897D52C0836C59BE2E5D44407EFFE6C5897D52C087C1FC15325D444071033E3F8C7D52C0DBA6785C545D44407C6308008E7D52C03FA6B5696C5D4440F42F49658A7D52C054FEB5BC725D4440713788D68A7D52C0ED9C6681765D44403CDC0E0D8B7D52C0B036C64E785D44403B8E1F2A8D7D52C066A3737E8A5D4440D3F88557927D52C07D0569C6A25D44407D022846967D52C0E5D4CE30B55D4440BFF1B567967D52C07C0BEBC6BB5D44409B012EC8967D52C0DE1D19ABCD5D44400AF31E679A7D52C0081F4AB4E45D4440D47D00529B7D52C0EBE1CB44115E44403F00A94D9C7D52C068774831405E4440F7393E5A9C7D52C04339D1AE425E44409831056B9C7D52C090A2CEDC435E444003B4AD669D7D52C086CABF96575E44402670EB6E9E7D52C0048E041A6C5E44409C69C2F6937D52C03259DC7F645E4440DDED7A698A7D52C047C8409E5D5E44407842AF3F897D52C0EEB089CC5C5E4440B053AC1A847D52C0859675FF585E444033FCA71B287D52C04D4A41B7975E444042942F68217D52C03F00A94D9C5E44404885B185207D52C0E5B4A7E49C5E4440751C3F541A7D52C0E318C91EA15E4440C26856B60F7D52C03A94A12AA65E4440FA7953910A7D52C093DFA293A55E444057923CD7F77C52C0C63368E89F5E444003CE52B29C7C52C06C239EEC665E44409AB33EE5987C52C020EEEA55645E4440DFC0E446917C52C0CF6394675E5E4440A70183A44F7C52C0B60E0EF6265E44400E0F61FC347C52C0CE88D2DEE05D4440E1404816307C52C01FD95C35CF5D444091B6F1272A7C52C0A7069ACFB95D444014C95702297C52C0CC785BE9B55D4440807F4A95287C52C0567C43E1B35D4440CE3637A6277C52C047AD307DAF5D4440DAFE9595267C52C07D569929AD5D4440FB90B75CFD7B52C02159C0046E5D4440876EF607CA7B52C078B130444E5D4440438CD7BCAA7B52C0321CCF67405D44401DC9E53FA47B52C0938C9C853D5D4440BBED42739D7B52C0111615713A5D444026FF93BF7B7B52C02BBD361B2B5D444039ECBE63787B52C091B6F1272A5D4440F2599E07777B52C0D40D1478275D4440A3005130637B52C01DFF0582005D4440A3AF20CD587B52C08AC6DADFD95C4440EB8F300C587B52C050FC1873D75C444003ECA353577B52C0E6ADBA0ED55C444003AF963B337B52C04694F6065F5C4440D13AAA9A207B52C0F0A485CB2A5C4440486B0C3A217B52C0B9DE3653215C4440E814E467237B52C065C57075005C44404F73F222137B52C08EC70C54C65B4440020D36751E7B52C0367689EAAD5B4440669E5C53207B52C0EA7420EBA95B4440A92C0ABB287B52C0D6FF39CC975B4440C2BCC799267B52C0E9B5D958895B4440B3075A81217B52C04276DEC6665B44405DDA70581A7B52C0535C55F65D5B4440C70BE9F0107B52C03526C45C525B444093C7D3F2037B52C08B338639415B44407E8978EBFC7A52C0FC1BB4571F5B4440D4B32094F77A52C0D061BEBC005B444016BD5301F77A52C09C887E6DFD5A4440887E6DFDF47A52C07B82C476F75A4440ECA4BE2CED7A52C0AE0AD462F05A4440846055BDFC7A52C0EF3A1BF2CF5A4440C1E09A3BFA7A52C072FC5069C45A444068C9E369F97A52C0D95DA0A4C05A4440A94D9CDCEF7A52C050711C78B55A4440321AF9BCE27A52C0FD2D01F8A75A44400F0D8B51D77A52C0F566D47C955A4440A5F27684D37A52C0EB54F99E915A4440C843DFDDCA7A52C02BBF0CC6885A44402A36E675C47A52C0DB68006F815A44405C70067FBF7A52C03D4162BB7B5A44405DA45016BE7A52C05C8E57207A5A44408D25AC8DB17A52C0681F2BF86D5A44404C4D8237A47A52C063450DA6615A4440419C8713987A52C0185B0872505A4440B6476FB88F7A52C058C51B99475A4440B8C9A8328C7A52C0BF266BD4435A4440FA9B5088807A52C0D9CD8C7E345A4440A70A4625757A52C0AA605452275A4440B28174B1697A52C0DC63E943175A4440888384285F7A52C04240BE840A5A44405DA27A6B607A52C085CB2A6C065A4440764F1E166A7A52C0D175E107E759444011397D3D5F7A52C0F0D93A38D85944404C3448C1537A52C05DA79196CA594440419DF2E8467A52C0DC476E4DBA594440088F368E587A52C048A7AE7C96594440A84F72874D7A52C0F42F49658A594440BBEB6CC83F7A52C092E9D0E979594440AEB8382A377A52C0329067976F594440B5C01E13297A52C03A00E2AE5E5944408235CEA6237A52C026A8E15B58594440682096CD1C7A52C0BF29AC545059444019E42EC2147A52C0813E912749594440B0FD648C0F7A52C04910AE80425944403A014D840D7A52C062A06B5F405944405F0B7A6F0C7A52C0B62E35423F594440959A3DD00A7A52C06308008E3D594440A86DC328087A52C09BE5B2D1395944402DE8BD31047A52C00F290648345944404B1B0E4B037A52C021C84109335944406A82A8FB007A52C004E3E0D2315944401E335019FF7952C0996038D730594440BF44BC75FE7952C0A051BAF42F594440EFFCA204FD7952C0FAD005F52D59444074779D0DF97952C03E90BC73285944407B681F2BF87952C021AB5B3D275944406917D34CF77952C00A83328D265944404084B872F67952C0C3D66CE525594440FFAECF9CF57952C04CA60A4625594440350A4966F57952C03A3B191C255944405323F433F57952C0F94B8BFA2459444077137CD3F47952C0A6F10BAF24594440942C27A1F47952C064027E8D24594440560DC2DCEE7952C05DC0CB0C1B594440755AB741ED7952C0410FB56D18594440D47C957CEC7952C053AEF02E17594440B1DAFCBFEA7952C0EEE87FB9165944402368CC24EA7952C0DC7D8E8F165944405FB4C70BE97952C089230F4416594440D0419770E87952C077B81D1A1659444065A54929E87952C0D7C05609165944409B00C3F2E77952C036C98FF815594440D42B6519E27952C047E350BF0B594440B2F4A10BEA7952C05C01857AFA58444009A4C4AEED7952C066F6798CF258444021037976F97952C06E15C440D75844409DD32CD0EE7952C0A46DFC89CA584440CE8B135FED7952C05247C7D5C85844408BFD65F7E47952C009168733BF5844401C40BFEFDF7952C0CBF6216FB9584440B33F506EDB7952C0747B4963B4584440C8940F41D57952C0B96E4A79AD584440FF06EDD5C77952C0D349B6BA9C58444093331477BC7952C0B77BB94F8E5844400C0055DCB87952C03605323B8B584440F068E388B57952C0C6F99B50885844401E34BBEEAD7952C0179B560A8158444085B2F0F5B57952C0BCADF4DA6C584440BAD91F28B77952C0ACAA97DF69584440BABC395CAB7952C006B64AB03858444014EB54F99E7952C01188D7F50B584440A98592C9A97952C0691A14CD0358444093FDF334607952C06C205D6C5A574440170D198F527952C01A8524B37A57444005854199467952C0AD6C1FF2965744409F3A56293D7952C02C98F8A3A85744401230BABC397952C0B2632310AF574440DD2230D6377952C0691B7FA2B257444061FBC9181F7952C097A608707A5744403140A209147952C05017299485574440567E198C117952C02BD9B111885744407BBC900E0F7952C0D7169E978A5744407FDAA84E077952C002637D039357444083F8C08EFF7852C0FE2AC0779B57444087307E1AF77852C0E1968FA4A4574440B515FBCBEE7852C0E449D235935744407F69519FE47852C065A9F57EA3574440EACE13CFD97852C0B6847CD0B35744402B8716D9CE7852C0CB7EDDE9CE5744408F8D40BCAE7852C070D1C952EB574440AF08FEB7927852C0EF1989D0085844403FFD67CD8F7852C0719010E50B5844401C2785798F7852C0764D486B0C584440F697DD93877852C0ACAB02B51858444037363B527D7852C0093543AA28584440C3D50110777852C09355116E32584440EEE714E4677852C03387A4164A584440717500C45D7852C07EA5F3E1595844405791D101497852C09D7DE5417A5844401AC1C6F5EF7752C0B9162D40DB5844400F7C0C569C7752C03EE8D9ACFA58444005508C2C997752C09259BDC3ED584440AC38D55A987752C0D1217024D0584440533BC3D4967752C04B5645B8C9584440E7FF55478E7752C05DC2A1B7785844402FFA0AD28C7752C0581CCEFC6A584440DCB930D28B7752C021567F8461584440FB20CB82897752C062D7F6764B58444079909E22877752C0D89942E7355844408C63247B847752C0B58993FB1D584440ACE46377817752C0677E350708584440C6C210397D7752C0B2F4A10BEA57444074B680D07A7752C0909DB7B1D9574440DB317557767752C0077767EDB65744409A7631CD747752C02D7B12D89C5744400D6C9560717752C054FEB5BC72574440FC34EECD6F7752C0A3E6ABE4635744409E7AA4C16D7752C0D1949D7E50574440FE9C82FC6C7752C0E046CA16495744401E4FCB0F5C7752C09B53C90050574440D503E621537752C0E063B0E25457444037DC476E4D7752C032569BFF5757444070ED4449487752C0836C59BE2E57444066F50EB7437752C054C554FA0957444032022A1C417752C0713C9F01F55644404487C091407752C01F7EFE7BF05644406E4E2503407752C05D4C33DDEB56444088F546AD307752C03ECBF3E0EE5644401F0F7D772B7752C04835ECF7C4564440A33B889D297752C026AAB706B656444087A4164A267752C0938E72309B5644403B6F63B3237752C050FD834886564440D7F7E120217752C00D6C956071564440132A38BC207752C07A8A1C226E564440315D88D51F7752C07E8E8F1667564440D4F02DAC1B7752C0ADA415DF505644408D4468041B7752C0952BBCCB45564440B88D06F0167752C0BB46CB811E564440A435069D107752C0C8E88024EC554440C9703C9F017752C0F01307D0EF55444083DE1B43007752C0855D143DF05544404EB4AB90F27652C0A69718CBF45544401ABE8575E37652C0C214E5D2F8554440293C6876DD7652C0807D74EACA5544403FABCC94D67652C0F58079C8945544405AD76839D07652C0B41D537765554440849ECDAACF7652C0272D5C56615544405DA79196CA7652C0D87F9D9B36554440331477BCC97652C06A10E6762F554440B41F2922C37652C07B82C476F75444406F2C280CCA7652C030815B77F35444405164ADA1D47652C0BC202235ED544440685BCD3AE37652C0F4311F10E8544440D6E429ABE97652C04203B16CE65444408B4E965AEF7652C0A23F34F3E454444080BA8102EF7652C0C77DAB75E2544440B515FBCBEE7652C0B64604E3E05444407C992842EA7652C02DEC6987BF544440F9BA0CFFE97652C028637C98BD544440363B527DE77652C0001B1021AE544440A359D93EE47652C0378AAC359454444027BA2EFCE07652C05C8E57207A5444403A765089EB7652C0DB17D00B7754444064744012F67652C059A148F77354444027C0B0FCF97652C054185B0872544440D1C952EBFD7652C0200BD1217054444092AD2EA7047752C0E083D72E6D544440F488D1730B7752C0CF807A336A544440A6B73F170D7752C0357A3540695444406F287CB60E7752C0CAF78C4468544440B3D0CE69167752C0A9BD88B663544440F678211D1E7752C0888384285F544440834F73F2227752C0E3361AC05B544440C2F693313E7752C0C05AB56B42544440F834272F327752C06684B70721544440C4758C2B2E7752C03D0801F9125444408D959867257752C00E4A9869FB53444022C2BF081A7752C0247F30F0DC534440EF1CCA50157752C03599F1B6D2534440C0B2D2A4147752C06551D845D15344409048DBF8137752C09509BFD4CF53444067B5C01E137752C01F0DA7CCCD5344403E22A644127752C0D9942BBCCB534440A71FD4450A7752C029B16B7BBB534440C0AF9124087752C0E95DBC1FB75344400856D5CBEF7652C018062CB98A534440F71BEDB8E17652C098A0866F615344406403E962D37652C03197546D375344404A22FB20CB7652C0765089EB185344402A1900AAB87652C0BE0F070951524440E386DF4DB77652C01F63EE5A425244400F7D772B4B7652C005A568E55E524440FB3F87F9F27552C07D224F92AE5144405793A7ACA67552C0D7C0560916514440BEDA519CA37552C0A44FABE80F514440745B22179C7552C0E2CCAFE600514440DCD6169E977552C00B43E4F4F5504440A93121E6927552C05E807D74EA504440D13FC1C58A7552C056ED9A90D6504440096B63EC847552C0AB92C83EC8504440AE80423D7D7552C04127840EBA50444040F7E5CC767552C0D0967329AE504440632827DA557552C0DEE7F86871504440C8ED974F567552C05646239F57504440211FF46C567552C03674B33F5050444015713AC9567552C059DC7F643A5044404AB20E47577552C028B682A62550444037AB3E575B7552C0F7AE415F7A4F444045460724617552C0A94885B1854E4440F62686E4647552C02D978DCEF94D444036AE7FD7677552C018AE0E80B84D4440B9E00CFE7E7552C0B01F6283854D4440446B459BE37552C0C5E23785954C444012A27C410B7652C03C1405FA444C4440588B4F01307652C0B058C345EE4B4440A6457D923B7652C07C28D192C74B44402C9CA4F9637652C0A2957B81594B4440A81ABD1AA07652C0300C5872154B4440FBC8AD49B77652C035272F32014B44404127840EBA7652C02AE109BDFE4A44401DCBBBEA017752C02172FA7ABE4A4440130CE71A667752C0C6A2E9EC644A44400A4B3CA06C7752C0BEF8A23D5E4A4440A5D93C0E837752C06473D53C474A4440FDBCA948857752C06B98A1F1444A4440F0C000C2877752C0F0DE5163424A4440D8817346947752C04450357A354A4440BF28417FA17752C08099EFE0274A44400A2DEBFEB17752C0BCAE5FB01B4A44407FF8F9EFC17752C08C0DDDEC0F4A444053C90050C57752C0B14B546F0D4A44402E71E481C87752C0BF61A2410A4A44401EFB592C457852C09F39EB538E494440056D72F8A47852C06D8E739B7049444036AD1402B97852C0D68BA19C68494440F59F353FFE7852C0BAA0BE654E494440289A07B0C87952C0C58F31772D4944406133C005D97952C0D862B7CF2A494440E1783E03EA7952C04DDA54DD2349444046B3B27DC87A52C06A11514CDE4844402F185C73477B52C0FCE25295B6484440A26131EA5A7B52C06A696E85B04844408499B67F657B52C036902E36AD4844404F8F6D19707B52C0C1C760C5A94844402E1D739EB17B52C02BDCF29194484440F9122A38BC7B52C0B5132521914844401021AE9CBD7B52C080D250A39048444081CEA44DD57B52C0431B800D88484440BBB88D06F07B52C076A38FF980484440B5A50EF27A7C52C07780272D5C484440F7C77BD5CA7C52C08AE5965643484440614D6551D87C52C05CFDD8243F484440E84CDA54DD7C52C03F1878EE3D4844409947FE60E07C52C05774EB353D484440AF0793E2E37C52C0FF5C34643C48444065A54929E87C52C0C45E28603B484440EFAB72A1F27C52C01F12BEF737484440D07D39B35D7D52C0075F984C1548444025AB22DC647D52C03D0801F912484440C39E76F86B7D52C0861C5BCF104844401211FE45D07F52C0F2CEA10C55474440B804E09F528252C0785C548B884644407615527E528252C0DB85E63A8D464440E2E5E95C518252C0BB270F0BB546444089B48D3F518252C0A7203F1BB94644400858AB764D8252C0F294D5743D474440CD565EF23F8252C07D7555A0164944401B28F04E3E8252C0E9F010C64F494440AAB4C5353E8252C0BDC117265349444032CB9E04368252C0F6285C8FC24944405111A7936C8252C09FE238F06A4B44402252D32EA68252C0BC02D193324D44404C50C3B7B08252C0F9F36DC1524D4440D26F5F07CE8252C0E34F5436AC4D4440A774B0FECF8252C0C266800BB24D4440A626C11BD28252C007431D56B84D4440EDD286C3D28252C0DC476E4DBA4D44402638F581E48252C04A5F0839EF4D444074779D0DF98252C0E3C281902C4E4440890629780A8352C016DC0F78604E44408315A75A0B8352C0E5EFDE51634E4440EA793716148352C036E84B6F7F4E44404703780B248352C0C24CDBBFB24E44403046240A2D8352C09BE09BA6CF4E4440A4C00298328352C02D776682E14E444055F833BC598352C09F91088D604F4440B3B27DC85B8352C08922A46E674F444075E789E76C8352C066118AADA04F44400D52F014728352C051F355F2B14F4440C5ABAC6D8A8352C0D4D00660035044403D7E6FD39F8352C05C1ABFF04A5044405051F52B9D8352C042B28009DC504440'

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

-- expect census tract boundary at cartodb nyc from 2013
SELECT cdb_observatory.OBS_GetBoundary(
  cdb_observatory._TestPoint(),
  'us.census.tiger.census_tract',
  '2013'
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
  '2013'
) = '36047048500'::text As OBS_GetBoundaryId_cartodb_census_tract_with_year;

-- should give back '36047', the geoid of cartodb's county (King's/
--  Brooklyn, NY)
SELECT cdb_observatory.OBS_GetBoundaryId(
  cdb_observatory._TestPoint(),
  'us.census.tiger.county',
  '2013'
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
  '2013'
) = :'cartodb_county_geometry' OBS_GetBoundaryById_boundary_id_mismatch_geom_id;

-- should give null since boundary_id does not match geometry reference id
SELECT cdb_observatory.OBS_GetBoundaryById(
  '36047',
  'us.census.tiger.census_tract'
) IS NULL As OBS_GetBoundaryById_boundary_id_mismatch_geom_id;

\i test/sql/drop_fixtures.sql
