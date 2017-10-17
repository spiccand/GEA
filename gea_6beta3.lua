--[[
%% autostart
%% properties
%% globals
--]]

-- ==========================================================
-- GEA : Gestionnaire d'Evénements Automatique
-- v 6.00 beta
-- Créé par Steven en collaboration avec Pepite et Thibaut
-- Remerciement à :
-- tous les utilisateurs/testers/apporteurs d'idées du 
-- forum Domotique-fibaro.fr
-- ==========================================================


function config() 
  -- --------------------------------------------------------
  -- CONFIGURATON GENERALE
  -- --------------------------------------------------------
  GEA.checkEvery = 30
  GEA.debug = true
  GEA.portables = {84}
  GEA.globalvariables = "GEA_Tasks6beta"
  GEA.control = true
  
  -- --------------------------------------------------------
  --                "PLUGINS" GEA                          
  -- @Steven décline toute responsabilité d'INSTABILITE de GEA
  -- en cas d'utilisation de ces plugins, SUPPORT non ASSURE 
  -- --------------------------------------------------------
  -- Exemple d'option propres à l'utilisateur. 
  -- Je souhaite être averti s'il y a une détection (ID 112) pendant que
  -- je suis en vacances (Variable Globale "Presence" == Vacances)
  --  GEA.options.detection = {name="Detection",
  --          getValue = function(id_detecteur)
  --            return fibaro:getGlobalValue("Presence") == "Vacances" and fibaro:getValue(id_detecteur, "value") ~= "0"
  --          end,
  --        }

  --GEA.add( {"Detection", 112}, -1, "Un mouvement a été détecté pendant mes vacances, le #date# à #time#")  

  -- --------------------------------------------------------
  -- FIN CONFIGURATION GENERALE
  -- --------------------------------------------------------
end


function setEvents()  
  -- --------------------------------------------------------
  -- LE CODE UTILISATEUR DOIT ALLER ICI
  -- --------------------------------------------------------

  GEA.add({"Info+", "serverStatus", os.time()-120}, 0, "Box redémarée à #time# le #date#")
  GEA.add(true, 0, "Démarrage de GEA le #date# à #time#")
  GEA.add({"Info", "updateStableAvailable", true }, 24*60*60, "Une nouvelle version est disponible", {"Repeat"})
  GEA.add({"Info", "updateBetaAvailable", true }, 24*60*60, "Une nouvelle version BETA est disponible", {"Repeat"})
  
  -- --------------------------------------------------------
  -- FIN DU CODE UTILISATEUR
  -- --------------------------------------------------------
end

-- ==========================================================
-- NE PLUS RIEN TOUCHER
-- ==========================================================
-- ----------------------------------------------------------
-- Tout ce que GEA sait faire est ici
-- ----------------------------------------------------------
if (not GEA) then
  
  if not tools then tools={version="2.00",addstyle="",isdebug=false,log=function(a,b,c)a=tools.tostring(a)for d,e in string.gmatch(a,"(#spaces(%d+)#)")do local f=""for g=1,e do f=f.."."end;a=string.gsub(a,d,"<span style=\"color:black;"..tools.addstyle.."\">"..f.."</span>")end;if tools.isdebug or c then fibaro:debug("<span style=\"color:"..(b or"white")..";"..tools.addstyle.."\">"..a.."</span>")end end,error=function(a,b)tools.log(a,b or"red",true)end,warning=function(a,b)tools.log(a,b or"orange",true)end,info=function(a,b)tools.log(a,b or"white",true)end,debug=function(a,b)tools.log(a,b or"gray",false)end,tostring=function(h)if type(h)=="boolean"then if h then return"true"else return"false"end elseif type(h)=="table"then if json then return json.encode(h)else return"table found"end else return tostring(h)end end,split=function(i,j)local j,k=j or":",{}local l=string.format("([^%s]+)",j)i:gsub(l,function(m)k[#k+1]=m end)return k end,trim=function(n)return n:gsub("^%s*(.-)%s*$","%1")end,deep_print=function(o)for g,p in pairs(o)do if type(p)=="table"then deep_print(p)else print(g,p)end end end,iif=function(q,r,s)if q then return r else return s end end,cut=function(t,u)u=u or 10;if u<t:len()then return t:sub(1,u-3).."..."end;return t end,isNumber=function(v)if type(v)=="number"then return true end;if type(v)=="string"then return type(tonumber(v))=="number"end;return false end,getStringTime=function(w)if w then return os.date("%H:%M:%S")end;return os.date("%H:%M")end,toTime=function(x)local y,z=string.match(x,"(%d+):(%d+)")local A=os.date("*t")local B=os.time{year=A.year,month=A.month,day=A.day,hour=y,min=z,sec=0}if B<os.time()then B=os.time{year=A.year,month=A.month,day=A.day+1,hour=y,min=z,sec=0}end;return B end,getStringDate=function()return os.date("%d/%m/%Y")end,isNil=function(C)return type(C)=="nil"end,isNotNil=function(C)return not tools.isNil(C)end}end
  tools.addstyle = "padding-left: 125px; display:inline-block; width:80%; margin-top:-18px; padding-top:-18px;"
  
  GEA = {}
  
  GEA.globalvariables = "GEA_Tasks"
  GEA.pluginsvariables = "GEA_Plugins"
  GEA.control = true
  GEA.power = tools.iif(api, "power", "valueSensor")
  GEA.version = "6.00beta3"
  GEA.checkEvery = 30       -- durée en secondes
  GEA.debug = true          -- mode d'affiche debug on/off
  GEA.secureAction = true   -- utilise pcall() ou pas
  GEA.source = fibaro:getSourceTrigger()
  GEA.language = "fr"
  
  GEA.portables = {} 
  GEA.moduleNames = {}
  GEA.moduleRooms = {}
  GEA.variables = {} 
  GEA.plugins = {}
  GEA.output = nil
  GEA.stoppedTasks = {}
  
  GEA.traduction = {
    en = {        
        id_missing          = "ID : %s doesn't exists",
        global_missing      = "Global : %s doesn't exists",
        not_number          = "%s must be a number",
        from_missing        = "&lt;from&gt; is mandatory",
        varCacheInstant     = "VariableCache doesn't work with event instance",
        central_missing     = "id, key et attribute are mandatory",
        property_missing    = "Property : %s can't be found",
        option_missing      = "Option : %s is missing",
        not_an_action       = "Option : %s can't be used as an action",
        not_math_op         = "Option : %s doesn't allow + or - operations",
        hour                = "hour",
        hours               = "hours",
        andet               = "and",
        minute              = "minute",
        minutes             = "minutes",
        second              = "second",
        seconds             = "seconds",
        err_cond_missing    = "Error : condition(s) required",
        err_dur_missing     = "Error : duration required", 
        err_msg_missing     = "message required, empty string is allowed",
        not_an_condition    = "Option : %s can't be used as a condition",
        no_action           = "< no action >",
        repeated            = "repeat",
        stopped             = "stopped",
        maxtime             = "MaxTime",
        add_event           = "Add immediately :",
        add_auto            = "Add auto :",
        gea_failed          = "GEA ... STOPPED",
        validate            = "Validation",
        action              = "action",
        err_check           = "Error, check : ",
        date_format         = "%d.%m.%y",
        hour_format         = "%X",
        input_date_format   = "dd/mm/yyyy",
        quit                = "Quit",
        gea_run_since       = "GEA run since %s",
        gea_check_nbr       = "... check running #%d ...",
        gea_start           = "Started automatically of GEA %s (mode %s)",
        gea_start_event     = "Started by event of GEA %s (mode %s [%s])",
        gea_minifier        = "Use minifiertools v. %s",
        gea_check_every     = "Check automatic every %s seconds",
        gea_global_create   = "Creation of %s global variable",
        gea_load_usercode   = "Loading user code setEvents() ...",
        gea_nothing         = "No entry to check",
        gea_start_time      = "GEA started on %s at %s ...",
        gea_stopped_auto    = "GEA has stopped running in automatic mode",
        week_short          = {"mo", "tu", "we", "th", "fr", "sa", "su"},
        week                = {"monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"},
        weekend             = "Weekend",
        weekdays            = "Weekdays",
        search_plugins      = "Searching plugins, ...",
        plugins_none        = "Found any",
        plugin_not_found    = "Plugin not found"
    }, 
    fr = {
        id_missing          = "ID : %s n'existe(nt) pas",
        global_missing      = "Global : %s n'existe(nt) pas",
        not_number          = "%s doit être un numéro",
        from_missing        = "&lt;from&gt; est obligatoire",
        varCacheInstant     = "VariableCache ne fonctionne pas avec les déclenchements instantanés",
        central_missing     = "id, key et attribute sont obligatoires",
        property_missing    = "Propriété: %s introuvable",
        option_missing      = "Option : %s n'existe pas",
        not_an_action       = "Option : %s ne peut pas être utilisé comme action",
        not_math_op         = "Option : %s n'autorise pas les + ou -",
        hour                = "heure",
        hours               = "heures",
        andet               = "et",
        minute              = "minute",
        minutes             = "minutes",
        second              = "seconde",
        seconds             = "secondes",
        err_cond_missing    = "Erreur : condition(s) requise(s)",
        err_dur_missing     = "Erreur : durée requise", 
        err_msg_missing     = "message requis, chaine vide autorisée",
        not_an_condition    = "Option : %s ne peut pas être utilisé comme une condition",
        no_action           = "< pas d'action >",
        repeated            = "répété",
        stopped             = "stoppé",
        maxtime             = "MaxTime",
        add_event           = "Ajout immédiat :",
        add_auto            = "Ajout auto :",
        gea_failed          = "GEA ... ARRETE",
        validate            = "Validation",
        action              = "action",
        err_check           = "Erreur, vérifier : ",
        date_format         = "%d.%m.%y",
        hour_format         = "%X",
        input_date_format   = "dd/mm/yyyy",
        quit                = "Quitter",
        gea_run_since       = "GEA fonctionne depuis %s",
        gea_check_nbr       = "... vérification en cours #%d ...",
        gea_start           = "Démarrage automatique de GEA %s (mode %s)",
        gea_start_event     = "Démarrage par évenement de GEA %s (mode %s [%s])",
        gea_minifier        = "Utilisation de minifiertools v. %s",
        gea_check_every     = "Vérification automatique toutes les %s secondes",
        gea_global_create   = "Création de la variable globale : %s",
        gea_load_usercode   = "Chargement du code utilisateur setEvents() ...",
        gea_nothing         = "Aucun traitement à effectuer",
        gea_start_time      = "GEA a démarré le %s à %s ...",
        gea_stopped_auto    = "GEA est arrêté en mode automatique",
        week_short          = {"lu", "ma", "me", "je", "ve", "sa", "di"},
        week                = {"lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"},
        weekend             = "Weekend",
        weekdays            = "Semaine",
        search_plugins      = "Recherche de plugins, ...",
        plugins_none        = "Aucun plugins trouvé",
        plugin_not_found    = "Plugin inexistant"
    }
  }  
 
  -- ----------------------------------------------------------
  -- Déclaration de toutes les fonctions de GEA
  --   f    = {name="Nouvelle fonction", 
  --                  math=true, -- autorise les + et -
  --                  keepValues = true, ne traduit pas les sous-table {"TurnOn", 73} reste ainsi et non pas true ou false
  --                  control=function(name,value) if (...) then return true else return false, "Message d'erreur" end end,
  --                  getValue=function(name) return <la valeur> end, 
  --                  action=function(name,value) <effectuer l'action> end
  --              },
  -- ----------------------------------------------------------
  GEA.options = {
    number    = {name="ID",
                    control=function(id) if (type(id) ~= "table") then id = {id} end local res, msg = true, "" for i=1, #id do if (not fibaro:getName(id[i])) then res = false msg = msg .. id[i] .. " " end end return res, string.format(GEA.trad.id_missing, msg) end,
                    getValue=function(id) return tonumber(fibaro:getValue(id, "value")) end, 
                },
    boolean   = {name="Boolean",
                    getValue=function(bool) return bool end, 
                },
    global    = {name="Global", 
                    math=true, -- autorise les Global+ et Global-
                    control=function(name,value) if (type(name) ~= "table") then name = {name} end local res, msg = true, "" for i=1, #name do if (not fibaro:getGlobalValue(name[i])) then res = false msg = msg .. name[i] .. " " end end return res, string.format(GEA.trad.global_missing, msg) end,
                    getValue=function(name) return fibaro:getGlobalValue(name) end, 
                    action=function(name,value) 
                      if (type(name) ~= "table") then name = {name} end
                      for i=1, #name do fibaro:setGlobal(name[i], GEA.getMessage(GEA.incdec(value, GEA.options.global.getValue(name[i])))) end
                    end
                },
    value     = {name="Value", 
                    math=true, -- autorise les Value+ et Value-
                    control=function(id, value) return GEA.options.number.control(id) end, 
                    getValue=function(id) if (not id) then id = GEA.currentMainId end return fibaro:getValue(id, "value") end, 
                    action=function(id, value) if (not value) then value = id id = GEA.currentMainId end if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:call(id[i],"setValue",GEA.incdec(value, GEA.options.value.getValue(id[i]))) end end
                },
    value2    = {name="Value2", 
                    math=true, -- autorise les Value+ et Value-
                    control=function(id, value) return GEA.options.value.control(id) end, 
                    getValue=function(id) if (not id) then id = GEA.currentMainId end return fibaro:getValue(id, "value2") end, 
                    action=function(id, value) if (not value) then value = id id = GEA.currentMainId end if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:call(id[i],"setValue2",GEA.incdec(value, GEA.options.value2.getValue(id[i]))) end end
                },
    property  = {name="Property", 
                    math=true,
                    control=function(id) return GEA.options.number.control(id) end, 
                    getValue=function(id, property) return fibaro:getValue(id, property) end,
                    action=function(id, property, value) if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:call(id[i], "setProperty", property, GEA.getMessage(GEA.incdec(value, GEA.options.property.getValue(id, property)))) end end
                },
    turnon    = {name="TurnOn", 
                    control=function(id) if (not id) then id = GEA.currentMainId end return GEA.options.number.control(id) end, 
                    getValue=function(id) if (not id) then id = GEA.currentMainId end  return tonumber(fibaro:getValue(id, "value"))>0 end, 
                    action=function(id, duree) if (not id) then id = GEA.currentMainId end if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:call(id[i],"turnOn") end if (duree) then setTimeout(function() for i=1, #id do fibaro:call(id[i],"turnOff") end end, duree * 1000) end end
                },
    turnoff   = {name="TurnOff", 
                    control=function(id) if (not id) then id = GEA.currentMainId end return GEA.options.turnon.control(id) end, 
                    getValue=function(id) if (not id) then id = GEA.currentMainId end return tonumber(fibaro:getValue(id, "value"))==0 end, 
                    action=function(id, duree) if (not id) then id = GEA.currentMainId end if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:call(id[i],"turnOff") end if (duree) then setTimeout(function() for i=1, #id do fibaro:call(id[i],"turnOn") end end, duree * 1000) end end
                },
    switch    = {name="Switch", 
                    control=function(id) if (not id) then id = GEA.currentMainId end return GEA.options.turnon.control(id) end, 
                    action=function(id) if (not id) then id = GEA.currentMainId end if (type(id) ~= "table") then id = {id} end for i=1, #id do if (tonumber(fibaro:getValue(id[i], "value"))>0) then fibaro:call(id[i],"turnOff") else fibaro:call(id[i],"turnOn") end end end
                },
    armed     = {name="Armed", 
                    control=function(id) if (not id) then id = GEA.currentMainId end return GEA.options.number.control(id) end,
                    getValue=function(id) if (not id) then id = GEA.currentMainId end return tonumber(fibaro:getValue(id, "armed"))==1 end, 
                },
    disarmed  = {name="Disarmed", 
                    control=function(id) if (not id) then id = GEA.currentMainId end return GEA.options.number.control(id) end,
                    getValue=function(id) if (not id) then id = GEA.currentMainId end return tonumber(fibaro:getValue(id, "armed"))==0 end, 
                },
    setarmed     = {name="Armed", 
                    control=function(id) if (not id) then id = GEA.currentMainId end return GEA.options.number.control(id) end,
                    getValue=function(id) if (not id) then id = GEA.currentMainId end return tonumber(fibaro:getValue(id, "armed"))==1 end, 
                    action=function(id) if (not id) then id = GEA.currentMainId end if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:call(id[i],"setArmed", 1) end end
                },
    setdisarmed  = {name="Disarmed", 
                    control=function(id) if (not id) then id = GEA.currentMainId end return GEA.options.number.control(id) end,
                    getValue=function(id) if (not id) then id = GEA.currentMainId end return tonumber(fibaro:getValue(id, "armed"))==0 end, 
                    action=function(id) if (not id) then id = GEA.currentMainId end if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:call(id[i],"setArmed", 0) end end
                },
    sensor    = {name="Sensor",
                    math=true,
                    control=function(id) if (not id) then id = GEA.currentMainId end return GEA.options.number.control(id) end,
                    getValue=function(id) if (not id) then id = GEA.currentMainId end return fibaro:getValue(id, GEA.power) end
                },
    virtualdevice = {name="VirtualDevice", 
                    control=function(id, button) local check, message = GEA.options.number.control(id) if (check) then return tools.isNumber(button), string.format(GEA.trad.not_number, button) else return check, message end end,
                    action=function(id, button) if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:call(id[i], "pressButton", tostring(button)) end end
                },
    label     = {name="Label",
                    math=true,
                    control=function(id, property, value) return GEA.options.number.control(id) end,
                    getValue=function(id, property) return fibaro:getValue(id, "ui."..property:gsub("ui.", ""):gsub(".value", "")..".value") end, 
                    action=function(id, property, value) if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:call(id[i], "setProperty", "ui."..property..".value", GEA.getMessage(GEA.incdec(value, GEA.options.label.getValue(id, property)))) end end
                },
    time      = {name="Time", 
                    control=function(from, to) if (from and from:len()>0 ) then return true else return false, GEA.trad.from_missing end end,
                    getValue=function(from, to) if (not to) then to = from end return GEA.checkTime(from, to) end
                },
    days      = {name="Days", 
                    getValue=function(days) return GEA.checkDays(days) end
                },
    dates     = {name="Dates", 
                    control=function(from, to) if (from and from:len()>0 ) then return true else return false, GEA.trad.from_missing end end,
                    getValue=function(from, to) return GEA.checkDates(from, to) end
                },
    dst       = {name="DST", 
                    getValue=function() return os.date("*t", os.time()).isdst end
                },
    nodst     = {name="NODST", 
                    getValue=function() return not os.date("*t", os.time()).isdst end
                },
    weather   = {name="Weather",
                    math=true, 
                    getValue=function(property, value) if (not value) then property = "WeatherCondition" end return fibaro:getValue(3, property) end
                },
    battery   = {name="Battery", 
                    math=true,
                    control=function(id) return GEA.options.number.control(id) end,
                    getValue=function(id) return fibaro:getValue(id, 'batteryLevel') end
                },
    batteries = {name="Batteries", 
                    getValue=function(value) return GEA.batteries(value) end,
                    getName=function(value) local _, names, _ = GEA.batteries(value) return names end,
                    getRoom=function(value) local _, _, rooms = GEA.batteries(value) return rooms end
                },
    dead      = {name="Dead", 
                    control=function(id) return GEA.options.number.control(id) end,
                    getValue=function(id) return tonumber(fibaro:getValue(id, "dead"))>0 end, 
                    action=function(id) if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:wakeUpDeadDevice(id[i]) end end
                },
    sceneactivation = {name="SceneActivation", 
                    getValue=function(id, value) return tonumber(fibaro:getValue(id, "sceneActivation")) == tonumber(value) end
                },
    fonction  = {name="Function", 
                    getValue=function(func) return func() end, 
                    action=function(func) func() end
                },
    copyglobal= {name="CopyGlobal", 
                    action=function(source,destination) fibaro:setGlobal(destination, fibaro:getGlobalValue(source)) end
                },
    portable  = {name="Portable", 
                    action=function(id, message) if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:call(id[i], "sendPush", GEA.getMessage(message)) end end
                },
    email     = {name="Email", 
                    action=function(id, message, sujet) if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:call(id[i], "sendEmail", sujet or ("GEA " .. GEA.version), GEA.getMessage(message)) end end
                },
    currenticon= {name="CurrentIcon", 
                    getValue=function(id) return fibaro:getValue(id, "currentIcon") end, 
                    action=function(id, value) if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:call(id[i], "setProperty", "currentIcon", value) end end
                },
    scenario  = {name="Scenario", 
                    action=function(id, args) if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:startScene(id[i], args) end end
                },
    killscenario  = {name="Kill", 
                    action=function(id) if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:killScenes(id[i]) end end
                },
    picture   = {name="Picture", 
                    action=function(id, destinataire) if (type(id) ~= "table") then id = {id} end if (type(destinataire) ~= "table") then destinataire = {destinataire} end for i=1, #id do for j =1, #destinataire do fibaro:call(id[i], "sendPhotoToUser", destinataire[j]) end end end
                },
    picturetoemail   = {name="PictureToEmail", 
                    action=function(id, destinataire) if (type(id) ~= "table") then id = {id} end if (type(destinataire) ~= "table") then destinataire = {destinataire} end for i=1, #id do for j =1, #destinataire do fibaro:call(id[i], "sendPhotoToEmail", destinataire[j]) end end end
                },
    open      = {name="Open", 
                    math=true,
                    control=function(id) return GEA.options.number.control(id) end,
                    getValue=function(id) return GEA.options.value.getValue(id) end,
                    action=function(id, value) if (not id) then id = GEA.currentMainId end if (not value) then value = 100 end GEA.options.value.action(id, value) end
                },
    close     = {name="Close",
                    math=true,
                    control=function(id) return GEA.options.open.control(id) end,
                    getValue=function(id) return GEA.options.value.getValue(id) end,
                    action=function(id, value) if (not id) then id = GEA.currentMainId end if (not value) then value = 0 end GEA.options.value.action(id, value) end
                },
    stop      = {name="Stop", 
                    control=function(id) return GEA.options.number.control(id) end,
                    action=function(id) if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:call(id[i], "stop") end end
                },
    apipost    = {name="ApiPost", 
                    getValue=function(url, data) __assert_type(data, "table") return api.post(url, data) end,
                    action=function(url, data) __assert_type(data, "table") api.post(url, data) end
                },
    apiput    = {name="ApiPost", 
                    getValue=function(url, data) __assert_type(data, "table") return api.put(url, data) end,
                    action=function(url, data) __assert_type(data, "table") api.put(url, data) end
                },
    apiget    = {name="ApiGet", 
                    math=true,
                    getValue=function(url) return api.get(url) end,
                    action=function(url) api.get(url) end
                },
    program   = {name="Program", 
                    math=true,
                    getValue=function(id) return fibaro:getValue(id, "currentProgram") end, 
                    action=function(id, prog) if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:call(id[i], "startProgram", prog) end end
                },
    thermostatlevel   = {name="ThermostatLevel", 
                    control=function(id) return GEA.options.number.control(id) end,
                    getValue=function(id) return fibaro:getValue(id, "value") end,
                    action=function(id, value) if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:call(id[i], "setTargetLevel", tostring(GEA.incdec(value, GEA.options.thermostatlevel.getValue(id)))) end end
                },
    thermostattime   = {name="ThermostatTime", 
                    control=function(id) return GEA.options.thermostatlevel.control(id) end,
                    getValue=function(id) return fibaro:getValue(id, "timestamp") end,
                    action=function(id, value) if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:call(id[i], "setTime", value) end end
                },
    ask       = {name="Ask",
                    action=function(id, message, scene) 
                      if (type(id) ~= "table") then id = {id} end
                      if (not scene) then scene = message message = GEA.getMessage() end
                      api.post('/mobile/push', {["mobileDevices"]=id,["message"]=GEA.getMessage(message),["title"]='HC2 Fibaro',["category"]='YES_NO',["data"]={["sceneId"]=scene}}) 
                    end
                },
    repe_t    = {name="Repeat", 
                    getValue=function() return true end,
                },
    notstart  = {name="NotStart", 
                    getValue=function() return true end,
                },                
    inverse   = {name="Inverse", 
                    getValue=function() return true end,
                },                
    maxtime   = {name="Maxtime", 
                    getValue=function(taskid) return fibaro:getGlobalValue(GEA.globalvariables):match("|M_" .. taskid .. "{(%d+)}") end,
                    action=function(taskid, number) fibaro:setGlobal(GEA.globalvariables, fibaro:getGlobalValue(GEA.globalvariables):gsub("|M_" .. taskid .. "{(%d+)}", "") .. "|M_" .. taskid .. "{"..number.."}") end
                },
    restarttask = {name="RestartTask", 
                    getValue=function(taskid) return fibaro:getGlobalValue(GEA.globalvariables):find("|R_" .. taskid) end,
                    action=function(taskid) if (type(taskid) ~= "table") then taskid = {taskid} end for i=1, #taskid do fibaro:setGlobal(GEA.globalvariables, fibaro:getGlobalValue(GEA.globalvariables):gsub("|R_" .. taskid[i], ""):gsub("|M_" .. taskid[i] .. "{(%d+)}", ""):gsub("|S_" .. taskid[i], "") .. "|R_" .. taskid[i]) end end
                },
    stoptask  = {name="StopTask", 
                    getValue=function(taskid) return fibaro:getGlobalValue(GEA.globalvariables):find("|S_" .. taskid) end,
                    action=function(taskid) if (type(taskid) ~= "table") then taskid = {taskid} end for i=1, #taskid do fibaro:setGlobal(GEA.globalvariables, fibaro:getGlobalValue(GEA.globalvariables):gsub("|S_" .. taskid[i], ""):gsub("|M_" .. taskid[i] .. "{(%d+)}", ""):gsub("|R_" .. taskid[i], "") .. "|S_" .. taskid[i]) end end
                },
    depend    = {name="Depend", 
                    control=function(entryId) return type(GEA.findEntry(entryId)) ~= "nil" end,
                    getValue=function(entryId) return not GEA.currentEntry.isWaiting[entryId] end,
                },
    test      = {name="Test", 
                    getValue=function(name1, name2, name3) print("test getValue() ") return name1 .. name2 .. name3, name1 end,
                    action=function(name) print("test action() " .. GEA.getMessage(name))end
                },
    sleep      = {name="Sleep", 
                    keepValues = true,
                    action=function(duree, option) local o = GEA.getOption(option) if (duree and o) then setTimeout(function() o.action(true) end, duree*1000) end end
                },
    variablecache = {name="VariableCache",
                    math=true,
                    control=function(var) return GEA.currentEntry.duration >= 0, GEA.trad.varCacheInstant end,
                    getValue=function(var, value) return GEA.variables[var] end,
                    action=function(var, value) GEA.variables[var] = GEA.getMessage(GEA.incdec(value, GEA.variables[var])) end,
                },
    enablescenario = {name="EnableScenario",
                    control=function(id) return GEA.options.number.control(id) end,
                    getValue=function(id) return fibaro:isSceneEnabled(id) end, 
                    action=function(id) if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:setSceneEnabled(id[i], true) end end
                },
    disablescenario = {name="DisableScenario",
                    control=function(id) return GEA.options.number.control(id) end,
                    getValue=function(id) return not fibaro:isSceneEnabled(id) end, 
                    action=function(id) if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:setSceneEnabled(id[i], false) end end
                },      
    setrunconfigscenario = {name="SetrunConfigScenario", 
                    control=function(id) return GEA.options.number.control(id) end,
                    getValue=function(id) return fibaro:getSceneRunConfig(id) end,
                    action=function(id, runconfig) if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:setSceneRunConfig(id[i], runconfig) end end
                },          
    countscenes = {name="CountScenes",
                    control=function(id) return GEA.options.number.control(id) end,
                    getValue=function(id) return fibaro:countScenes(id) end
                },                    
    popup       = {name="Popup",
                    action=function(typepopup,titlepopup,msgpopup) HomeCenter.PopupService.publish({title="GEA - "..titlepopup,subtitle = os.date(GEA.trad.date_format .. " - " .. GEA.trad.hour_format),contentTitle = "Information",contentBody=GEA.getMessage(msgpopup),img="..img/topDashboard/info.png",type=tools.tostring(typepopup),buttons={{caption=GEA.trad.quit,sceneId=0}}}) end
                },
    --{"DebugMessage", id_vd, "0|2", "Message", "error|debug"} -- uniquement pour VD
    debugmessage = {name="DebugMessage",
                    control=function(id) return GEA.options.number.control(id) end,
                    action=function(id, elementid, msgdebug, typedebug) if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:call(id[i], "addDebugMessage", elementid, GEA.getMessage(msgdebug), typedebug or debug) end end
                },
    -- {"Filters", "Lights|Blinds", "turnOff|Close|Open"}
    filters     = {name="Filters",
                    --control=function(id) return GEA.options.number.control(id) end,
                    action=function(typefilter,choicefilter) if typefilter:lower() == "lights" then for _,v in ipairs(fibaro:getDevicesId({properties = {isLight = true}})) do fibaro:call(v, choicefilter) end elseif typefilter:lower() =="blinds" then for _,v in ipairs(fibaro:getDevicesId({type = tools.tostring("com.fibaro.FGRM222")})) do fibaro:call(v, choicefilter) end end end
                },
    rgb         = {name="RGB",
                    control=function(id) return GEA.options.number.control(id) end,
                    action=function(id, r, g, b, w) if (type(id) ~= "table") then id = {id} end for i=1, #id do fibaro:call(id[i], "setColor", r or 0, g or 0, b or 0, w or 0) end end
                },
    centralsceneevent = {name="CentralSceneEvent",
                    control=function(id, key, attribute) return GEA.options.number.control(id) and type(key)~="nil" and type(attribute)~="nil", GEA.trad.central_missing end,
                    getValue=function(id, key, attribute) return (GEA.source.event.data.id==tonumber(id) and tostring(GEA.source.event.data.keyId)==tostring(key) and tostring(GEA.source.event.data.keyAttribute)==tostring(attribute)) end
                },
    frequency = {name="Frequency",
                    getValue=function(freqday, freqnumber) return GEA.getFrequency(freqday,freqnumber) end
                },
    reboothc2 = {name="RebootHC2",
                    action=function() HomeCenter.SystemService.reboot() end
                },
    shutdownhc2 = {name="ShutdownHC2",
                    action=function() HomeCenter.SystemService.shutdown() end
                },                
    alarm     = {name = "Alarm", 
                    control=function(id) return GEA.options.number.control(id) end,
                    getValue=function(id)                       
                      if (os.date("%H:%M") == fibaro:getValue(id, "ui.lblAlarme.value")) then
                        local days = fibaro:getValue(id, "ui.lblJours.value")
                        days = days:lower()
                        days = days:gsub(GEA.trad.week_short[1], "monday"):gsub(GEA.trad.week_short[2], "tuesday"):gsub(GEA.trad.week_short[3], "wednesday"):gsub(GEA.trad.week_short[4], "thursday"):gsub(GEA.trad.week_short[5], "friday"):gsub(GEA.trad.week_short[6], "saturday"):gsub(GEA.trad.week_short[7], "sunday")
                        -- a garder pour compatibilité ---
                        days = days:gsub("lu", "monday"):gsub("ma", "tuesday"):gsub("me", "wednesday"):gsub("je", "thursday"):gsub("ve", "friday"):gsub("sa", "saturday"):gsub("di", "sunday")
                        days = days:gsub("mo", "monday"):gsub("tu", "tuesday"):gsub("we", "wednesday"):gsub("th", "thursday"):gsub("fr", "friday"):gsub("sa", "saturday"):gsub("su", "sunday")
                        return days:find(os.date("%A"):lower()) ~= nil
                      end
                      return false
                    end,
                },
    info      = {name = "Info", 
                  math = true,
                  control=function(property) if (type(api.get("/settings/info")[property])=="nil") then return false, string.format(GEA.trad.property_missing, property) else return true end end,
                  getValue=function(property, value) return api.get("/settings/info")[property] end
                },
    pluginscenario = {name="PluginScenario",
                  control=function() if (GEA.plugins[GEA.currentAction.name]) then return true else return false, GEA.trad.plugin_not_found end end,
                  getValue=function(...) 
                    local args = {...}
                    local params = {{geaid = __fibaroSceneId}, {gealine = GEA.currentEntry.id}, {geamode = "value"}}
                    for i, v in ipairs(args) do table.insert(params, {["param"..i] = v}) end
                    local id = GEA.plugins[GEA.currentAction.name]
                    fibaro:startScene(id, params)
                  end,
                  action=function(...)
                    local args = {...}
                    local params = {{geaid = __fibaroSceneId}, {gealine = GEA.currentEntry.id}, {geamode = "action"}}
                    for i, v in ipairs(args) do table.insert(params, {["param"..i] = v}) end
                    local id = GEA.plugins[GEA.currentAction.name]
                    fibaro:startScene(id, params)
                  end
    			},
  }
  GEA.copyOption = function(option, newName) local copy = {} copy.name = newName or option.name if (option.math) then copy.math = option.math end if (option.control) then copy.control = option.control end if (option.getValue) then copy.getValue = option.getValue end if (option.action) then copy.action = option.action end return copy end
  
  -- Alias - GEA.copyOption(option, <nouveau nom>)
  GEA.options.vd = GEA.copyOption(GEA.options.virtualdevice, "VD")
  GEA.options.scene = GEA.copyOption(GEA.options.scenario)
  GEA.options.start = GEA.copyOption(GEA.options.scenario)
  GEA.options.startscene = GEA.copyOption(GEA.options.scenario)
  GEA.options.killscene = GEA.copyOption(GEA.options.killscenario)
  GEA.options.enablescene = GEA.copyOption(GEA.options.enablescenario)
  GEA.options.disablescene = GEA.copyOption(GEA.options.disablescenario)
  GEA.options.wakeup = GEA.copyOption(GEA.options.dead)
  GEA.options.photo = GEA.copyOption(GEA.options.picture, "Photo")
  GEA.options.phototomail = GEA.copyOption(GEA.options.picturetoemail, "PhotoToMail")
  GEA.options.thermostat = GEA.copyOption(GEA.options.thermostatlevel)
  GEA.options.startprogram = GEA.copyOption(GEA.options.program, "startProgram")
  GEA.options.push = GEA.copyOption(GEA.options.portable, "Push")
  GEA.options.power = GEA.copyOption(GEA.options.sensor, "Power")
  GEA.options.pressbutton = GEA.copyOption(GEA.options.virtualdevice, "PressButton")
  GEA.options.slide = GEA.copyOption(GEA.options.value2, "Slide")
  GEA.options.orientation = GEA.copyOption(GEA.options.value2, "Orientation")
  GEA.options.issceneenabled = GEA.copyOption(GEA.options.enablescenario, "isSceneEnabled")
  GEA.options.isscenedisabled = GEA.copyOption(GEA.options.disablescenario, "isSceneDisabled")
  GEA.options.runconfigscene = GEA.copyOption(GEA.options.setrunconfigscenario, "RunConfigScene")
  GEA.options.dayevenodd = GEA.copyOption(GEA.options.frequency, "DayEvenOdd")

  -- ----------------------------------------------------------
  -- Proposition pepite GEA.getFrequency pour Frequency 
  -- (code qui vient de toi deja)
  -- ----------------------------------------------------------
  GEA.getFrequency = function(day, number) --day : 1-31 wday :1-7 (1 :sunday)
		local t = os.date("*t")
		local semainepaire = os.date("%W") %2 == 0
		if (os.date("%A"):lower() == day:lower()) then
			return (number == 2 and semainepaire) or t["day"] < 8
		end
  end
  -- ----------------------------------------------------------
  -- fin proposition pepite
  -- ----------------------------------------------------------
  
  -- ----------------------------------------------------------
  -- Vérification des batteries
  -- ----------------------------------------------------------
  GEA.batteries = function(value) 
    local res = true 
    local names, rooms = "", ""
    for _, v in ipairs(fibaro:getDevicesId({interface="battery", visible=true})) do 
      local bat = fibaro:getValue(v, 'batteryLevel')
      local low = (tonumber(bat) < tonumber(value))
      if (low) then
        names = names .. "["..v.."] " ..fibaro:getName(v) .. ", " 
        rooms = rooms .. fibaro:getRoomNameByDeviceID(v)  .. ", " 
      end
      res = res or low
    end
    return res, names, rooms
  end
 
  -- ----------------------------------------------------------
  -- Recherche et retourne une option (condition ou action) 
  -- encapsulée
  -- ----------------------------------------------------------
  GEA.getOption = function(object, silent)
    local option = nil
    local sname = ""
    local tname = type(object)
    local originalName = object
    if (tname == "table") then 
      sname = string.lower(object[1]):gsub("!", ""):gsub("+", ""):gsub("-", "") 
      originalName = object[1]
    else
      sname = string.lower(tostring(object)):gsub("!", ""):gsub("+", ""):gsub("-", "")  
    end
    
    if (tonumber(sname)) then tname = "number" object = tonumber(sname) end
    if (tname=="number" or tname=="boolean") then 
        option = GEA.options[tname] 
        option.name = object
        originalName = tostring(originalName)
        object = {object}
    else
        if (sname == "function") then sname = "fonction" end
        if (sname == "repeat") then sname = "repe_t" end
        option = GEA.options[sname]
    end
    if (option) then
      return GEA.encapsule(option, object, originalName:find("!"), originalName:find("+"), originalName:find("-"))
    end
    if (not silent) then
      tools.error(string.format(GEA.trad.option_missing, __convertToString(originalName)) )
      fibaro:abort()
    end
  end

  -- ----------------------------------------------------------
  -- Encapsulation d'une option (condition ou action)
  -- ----------------------------------------------------------
  GEA.encapsule = function(option, args, inverse, plus, moins)
    local copy = {}
    copy.name = option.name
    copy.args = {table.unpack(args)}
    copy.inverse = inverse
    if (copy.args and #copy.args>0) then
       table.remove(copy.args, 1)
    end
    copy.getLog = function() 
          local params = "]"
          if (#copy.args>0) then 
            if (copy.name == "Function") then
                params = ", {...}" .. params
            else
              params = ", " .. __convertToString(copy.args) .. params
            end
          end
          return "["..tostring(copy.name) .. tools.iif(copy.inverse, "!", "") .. tools.iif(plus, "+", "") .. tools.iif(moins, "-", "") .. params
      end
    copy.lastvalue = ""
    copy.hasValue = type(option.getValue)=="function" or false
    copy.hasAction = type(option.action)=="function" or false
    copy.hasControl = type(option.control)=="function" or false
    copy.getModuleName = function() if (option.getName) then return option.getName(copy.searchValues()) end local id = copy.getId() if (type(id)=="number") then id = tonumber(id) if (not GEA.moduleNames[id]) then GEA.moduleNames[id] = fibaro:getName(id) end return GEA.moduleNames[id] else return "" end end
    copy.getModuleRoom = function() if (option.getRoom) then return option.getRoom(copy.searchValues()) end local id = copy.getId() if (type(id)=="number") then id = tonumber(id) if (not GEA.moduleRooms[id]) then GEA.moduleRooms[id] = fibaro:getRoomNameByDeviceID(id) end return GEA.moduleRooms[id] else return "" end end
    copy.getId = function()  
                    if (type(copy.name)=="boolean") then 
                      return copy.name
                    elseif (type(copy.name)=="number") then 
                      return copy.name
                    elseif (type(copy.name)=="function") then 
                      return nil
                    else 
                      return copy.args[1]
                    end
      end
    copy.searchValues = function(letit) 
                        if (type(copy.name)=="boolean") then 
                          return copy.name
                        elseif (type(copy.name)=="number") then 
                          return copy.name
                        else 
                          local results = {}
                          for i = 1, #args do
                            if (type(args[i]) == "table" and not option.keepValues and i > 2) then 
                              local o = GEA.getOption(args[i], true)
                              if (o) then table.insert(results, o.getValue()) else table.insert(results, args[i]) end
                            else
                              table.insert(results, args[i])
                            end
                          end
                          if (results and #results>0) then table.remove(results, 1) end
                          return table.unpack(results)
                        end
                      end
    copy.control = function() if (GEA.control and copy.hasControl) then return option.control(copy.searchValues()) else return true end end
    copy.action = function() if (copy.hasAction) then return option.action(copy.searchValues()) else tools.warning(string.format(GEA.trad.not_an_action, copy.name)) return nil end end
    copy.getValue = function() 
                        if (not copy.hasValue) then return end
                        if (type(args[2])=="function") then 
                          copy.lastvalue = args[2]() 
                        elseif (type(copy.name)=="boolean") then 
                          copy.lastvalue = GEA.options.boolean.getValue(copy.name)
                        elseif (type(copy.name)=="number") then 
                          copy.lastvalue = GEA.options.number.getValue(copy.name) 
                        else 
                          copy.lastvalue = option.getValue(copy.searchValues()) 
                        end 
                        return copy.lastvalue
                    end
    copy.check = function()
                        local id, property, value, value2, value3, value4 = copy.searchValues()
                        if (not copy.hasValue) then return true end
                        if (not property) then property = id end
                        if (not value) then value = property end
                        if (not value2) then value2 = value end
                        if (not value3) then value3 = value2 end
                        if (not value4) then value4 = value3 end
                        local result = copy.getValue()
                        if (type(copy.name)=="number") then 
                          result = (result > 0)
                        end
                        if (copy.inverse) then
                          if (type(value4)=="function") then local r, v = value4() return not r, v end
                          if (type(result)=="boolean") then return not result, result end
                          return not GEA.compareString(result, value4), result
                        else
                          if (type(result)=="boolean") then return result, result end
                          if (tools.isNil(option.math) and (plus or moins)) then
                            tools:error(string.format(GEA.trad.not_math_op, copy.name))
                            fibaro:abort()
                          end
                          if (plus or moins) then
                            local num1 = tonumber(string.match(value4, "[0-9.]+"))
                            local num2 = tonumber(string.match(result, "[0-9.]+"))
                            if (plus) then
                              return num2 > num1, result
                            else
                              return num2 < num1, result
                            end
                          end
                          if (type(value4)=="function") then return value4() end
                          return GEA.compareString(result, value4), result
                        end
                      end
    return copy
  end
  
  -- ----------------------------------------------------------
  -- Compare 2 chaînes de caractères (autorise les regex)
  -- ----------------------------------------------------------
  GEA.compareString = function(s1, s2)
    s1 = tostring(s1):lower()
    s2 = tostring(s2):lower()
    if (s2:find("#r#")) then
      s2 = s2:gsub("#r#", "")
      local res = false
      for _, v in pairs(tools.split(s2, "|")) do
        res = res or tostring(s1):match(tools.trim(v))
      end
      return res
    end
    return (tostring(s1) == tostring(s2))
  end
  
  -- ----------------------------------------------------------
  -- Trie un tableau selon sa propriété
  -- ----------------------------------------------------------  
  GEA.table_sort = function(t, property)
    local new1, new2 = {}, {}
    for k,v in pairs(t) do table.insert(new1, { key=k, val=v } ) end
    table.sort(new1, function (a,b) return (a.val[property] < b.val[property]) end)  
    for k,v in pairs(new1) do table.insert(new2, v.val) end
    return new2    
  end
  
  -- ----------------------------------------------------------
  -- Retourne year, month, days selon un format spécifique
  -- ----------------------------------------------------------    
  GEA.getDateParts = function(date_str, date_format)
    local d,m,y = date_format:find("dd"), date_format:find("mm"), date_format:find("yy")    
    local arr = { { pos=y, b="yy" }, { pos=m, b="mm" } , { pos=d, b="dd" }  }
    arr = GEA.table_sort(arr, "pos")
    date_format = date_format:gsub("yyyy","(%%d+)"):gsub("yy","(%%d+)"):gsub("mm","(%%d+)"):gsub("dd","(%%d+)"):gsub(" ","%%s")
    if (date_str and date_str~="") then     
        _, _, arr[1].c, arr[2].c, arr[3].c = string.find(string.lower(date_str), date_format)
    else
        return nil, nil, nil
    end
    arr = GEA.table_sort(arr, "b")
    return tonumber(arr[3].c), tonumber(arr[2].c), tonumber(arr[1].c)
  end
  
  -- ----------------------------------------------------------
  -- Gestion des inc+ et dec-
  -- ----------------------------------------------------------
  GEA.incdec = function(value, oldvalue)
    if (type(value) ~= "string") then return value end
    if (value:find("inc%+") or value:find("dec%-")) then
      local num = value:match("%d+") or 1
      local current = tonumber(oldvalue) or 0
      if (value:find("inc%+")) then value = current + num else value = current - num end
    end
    return value
  end
  
  -- ----------------------------------------------------------
  -- Converti un nombre de secondes en un format expressif 
  -- ----------------------------------------------------------
  GEA.getDureeInString = function(nbSecondes) 
    local dureefull = ""
    local duree = ""
    nHours = math.floor(nbSecondes/3600)
    nMins = math.floor(nbSecondes/60 - (nHours*60))
    nSecs = math.floor(nbSecondes - nHours*3600 - nMins *60)
    if (nHours > 0) then 
      duree = duree .. nHours .. "h " 
      dureefull = dureefull .. nHours
      if (nHours > 1) then dureefull = dureefull .. " " .. GEA.trad.hours else dureefull = dureefull .. " " .. GEA.trad.hour end
    end
    if (nMins > 0) then 
      duree = duree .. nMins .. "m " 
      if (nHours > 0) then dureefull = dureefull .. " " end
      if (nSecs == 0 and nHours > 0) then dureefull = dureefull .. "et " end
      dureefull = dureefull .. nMins
      if (nMins > 1) then dureefull = dureefull .. " " .. GEA.trad.minutes else dureefull = dureefull .. " " .. GEA.trad.minute end
    end
    if (nSecs > 0) then 
      duree = duree.. nSecs .. "s" 
      if (nMins > 0) then dureefull = dureefull .. " " .. GEA.trad.andet .. " " end
      dureefull = dureefull .. nSecs
      if (nSecs > 1) then dureefull = dureefull .. " " .. GEA.trad.seconds else dureefull = dureefull .. " "  .. GEA.trad.second end
    end

    return duree, dureefull
  end
  
  -- ----------------------------------------------------------
  -- Retourne les heures au bon format si besoin
  -- ----------------------------------------------------------
  GEA.flatTimes = function(from, to)
    return GEA.flatTime(from), GEA.flatTime(to or from)
  end
  
  -- ----------------------------------------------------------
  -- Retourne une heure au bon format si besoin
  -- ----------------------------------------------------------
  GEA.flatTime = function(time)

    local t = time:lower()
    t = t:gsub(" ", ""):gsub("h", ":"):gsub("sunset", fibaro:getValue(1, "sunsetHour")):gsub("sunrise", fibaro:getValue(1, "sunriseHour"))

    if (string.find(t, "<")) then
      t = GEA.flatTime(tools.split(t, "<")[1]).."<"..GEA.flatTime(tools.split(t, "<")[2])
    end
    if (string.find(t, ">")) then
      t = GEA.flatTime(tools.split(t, ">")[1])..">"..GEA.flatTime(tools.split(t, ">")[2])
    end

    if(string.find(t, "+")) then
      local time = tools.split(t, "+")[1]
      local add = tools.split(t, "+")[2]
      local td = os.date("*t")
      local minutes = tools.split(time, ":")[2]
      local sun = os.time{year=td.year, month=td.month, day=td.day, hour=tonumber(tools.split(time, ":")[1]), min=tonumber(tools.split(time, ":")[2]), sec=0}
      sun = sun + (add *60)
      t = os.date("*t", sun)
      t =  string.format("%02d", t.hour) ..string.format("%02d", t.min)
    elseif(string.find(t, "-")) then
      local time = tools.split(t, "-")[1]
      local add = tools.split(t, "-")[2]
      local td = os.date("*t")
      local sun = os.time{year=td.year, month=td.month, day=td.day, hour=tonumber(tools.split(time, ":")[1]), min=tonumber(tools.split(time, ":")[2]), sec=0}
      sun = sun - (add *60)
      t = os.date("*t", sun)
      t =  string.format("%02d", t.hour) ..string.format("%02d", t.min)			
    elseif (string.find(t, "<")) then
      local s1 = tools.split(t, "<")[1]
      local s2 = tools.split(t, "<")[2]
      s1 =  string.format("%02d", tools.split(s1, ":")[1]) .. ":" .. string.format("%02d", tools.split(s1, ":")[2])
      s2 =  string.format("%02d", tools.split(s2, ":")[1]) .. ":" .. string.format("%02d", tools.split(s2, ":")[2])
      if (s1 < s2) then t = s1 else t = s2 end
    elseif (string.find(t, ">")) then
      local s1 = tools.split(t, ">")[1]
      local s2 = tools.split(t, ">")[2]
      s1 =  string.format("%02d", tools.split(s1, ":")[1]) .. ":" .. string.format("%02d", tools.split(s1, ":")[2])
      s2 =  string.format("%02d", tools.split(s2, ":")[1]) .. ":" .. string.format("%02d", tools.split(s2, ":")[2])
      if (s1 > s2) then t = s1 else t = s2 end
    else
      t =  string.format("%02d", tools.split(t, ":")[1]) .. ":" .. string.format("%02d", tools.split(t, ":")[2])  
    end

    return t
  end
  
  -- ----------------------------------------------------------
  -- Contrôle des heures
  -- ----------------------------------------------------------
  GEA.checkTime = function(from, to)
		local now = os.date("%H%M")
    from, to = GEA.flatTimes(from, to)
    from = from:gsub(":", "")
    to = to:gsub(":", "")
		if (to < from) then
			return (now >= from) or (now <= to)
		else
			return (now >= from) and (now <= to)
		end
	end
  
  -- ----------------------------------------------------------
  -- Contrôle des dates
  -- ----------------------------------------------------------
  GEA.checkDates = function(from, to)
    local now = os.date("%Y%m%d")
    to = to or from
    local d,m,y = to:match("(%d+).(%d+).(%d+)")
    if (not y) then to = to .. GEA.trad.input_date_format:match("[/,.]") .. os.date("%Y") end
    local toy, tom, tod = GEA.getDateParts(to, GEA.trad.input_date_format)
    d,m,y = from:match("(%d+).(%d+).(%d+)")
    if (not y) then from = from .. GEA.trad.input_date_format:match("[/,.]") .. os.date("%Y") end
    local fromy, fromm, fromd = GEA.getDateParts(from, GEA.trad.input_date_format)
    from = string.format ("%04d", fromy) ..string.format ("%02d", fromm)..string.format ("%02d", fromd)
		to = string.format ("%04d", toy) ..string.format ("%02d", tom)..string.format ("%02d", tod)
		return tonumber(now) >= tonumber(from) and tonumber(now) <= tonumber(to)    
  end
  
  -- ----------------------------------------------------------
  -- Contrôle des jours
  -- ----------------------------------------------------------
 	GEA.checkDays = function(days)
    if (not days or days=="") then days = "All" end
    days = days:lower()
		local jours = days:gsub("all", "weekday,weekend")
    jours = jours:gsub(GEA.trad.weekdays, GEA.traduction.en.weekdays):gsub(GEA.trad.weekend, GEA.traduction.en.weekend)
    jours = jours:gsub(GEA.trad.week[1], GEA.traduction.en.week[1]):gsub(GEA.trad.week[2], GEA.traduction.en.week[2]):gsub(GEA.trad.week[3], GEA.traduction.en.week[3]):gsub(GEA.trad.week[4], GEA.traduction.en.week[4]):gsub(GEA.trad.week[5], GEA.traduction.en.week[5]):gsub(GEA.trad.week[6], GEA.traduction.en.week[6]):gsub(GEA.trad.week[7], GEA.traduction.en.week[7])
		jours = jours:gsub("weekday", "monday,tuesday,wednesday,thursday,friday"):gsub("weekdays", "monday,tuesday,wednesday,thursday,friday"):gsub("weekend", "saturday,sunday")
		return tools.isNotNil(string.find(jours:lower(), os.date("%A"):lower()))
	end
  
  -- ----------------------------------------------------------
  -- Traite les entrées spéciales avant de l'ajouter dans le tableau
  -- ----------------------------------------------------------
  GEA.insert = function(t, v, entry)
    if ((GEA.source["type"] == "autostart" and entry.duration<0) or (GEA.source["type"] ~= "autostart" and entry.duration>=0)) then return false end
    local action = tostring(v.name):lower()
    if (action == "repeat") then entry.repeating = true  return end
    if (action == "notstart") then entry.stopped = true  return end
    if (action == "portables") then entry.portables = v.args[1] return end
    if (action == "portable" or action == "push") then entry.portables = {v.args[1]} return end
    if (action == "inverse") then local num = v.args[1] or 1 entry.conditions[num].inverse = true return end
    if (action == "maxtime") then 
      local time = GEA.options.maxtime.getValue(entry.id)
      if (time and tonumber(time) < 1) then
        entry.stopped = true
      else
        entry.maxtime = v.args[1] 
        entry.repeating = true 
      end
      return 
    end
    if (action == "alarm") then entry.duration = 0 entry.repeating = true end
    if (action == "depend") then table.insert(GEA.findEntry(v.args[1]).listeners, entry.id) entry.isWaiting[v.args[1]]=true end
    table.insert(t, v)
    return true
  end
  
  GEA.id_entry = 0
  GEA.entries = {}
  
  -- ----------------------------------------------------------
  -- Retrouve une entry selon son ID
  -- ----------------------------------------------------------
  GEA.findEntry = function(entryId) 
      for i = 1, #GEA.entries do
        if (GEA.entries[i].id == entryId) then return GEA.entries[i] end
      end
  end
  
  -- ----------------------------------------------------------
  -- Permet l'ajout des entrées à traiter
  -- c : conditions
  -- d : duree
  -- m : message
  -- a : actions
  -- l : log
  -- ----------------------------------------------------------
  GEA.add = function(c, d, m, a, l)
      
    if (not c) then tools.error(GEA.trad.err_cond_missing) return end
    if (not d) then tools.error(GEA.trad.err_dur_missing) return end
    if (not m) then tools.error(GEA.trad.err_msg_missing) return end
    
    GEA.id_entry =   GEA.id_entry + 1
        
    local entry = {id=GEA.id_entry, conditions={}, duration=d, message=m, actions={}, repeating=false, maxtime=-1, count=0, stopped=false, listeners={}, isWaiting={}, lastvalid=nil, runned=false, log="#" .. GEA.id_entry .. " " ..tools.iif(l, tools.tostring(l), ""), portables=GEA.portables}
          
    local var = nil
    if (GEA.source.type == "global") then
      var = GEA.source.name
    elseif (GEA.source.type == "property") then 
      var = GEA.source.deviceID
    elseif (GEA.source.type == "event") then
      var = GEA.source.event.data.id
    end
    
    entry.mainid = -1
    local done = false
    if (type(c) == "table" and ( type(c[1]) == "table" or type(c[1]) == "number" or c[1]:find("%d+!") or type(c[1]) == "boolean")) then
      for i = 1, #c do 
          local res = GEA.insert(entry.conditions, GEA.getOption(c[i]), entry) 
          done = done or res
      end
    else
      done = GEA.insert(entry.conditions, GEA.getOption(c), entry)
    end
    if (done) then entry.mainid = entry.conditions[1].getId() end

    if (var) then
      local found = false
      for i = 1, #entry.conditions do
        if (tostring(entry.conditions[i].getId()) == tostring(var)) then found = true end
      end
      if (not found) then return end
    end
    
    if (a) then
      if (type(a) == "table" and type(a[1]) == "table") then
          for i = 1, #a do 
            if (type(a[i], "table") and a[i][1]:lower()=="if") then 
              GEA.insert(entry.conditions, GEA.getOption(a[i][2]), entry) 
            elseif (type(a[i], "table") and GEA.compareString(a[i][1]:lower(), "#r#^time|dates|days|dst|nodst|^armed|^disarmed")) then 
              GEA.insert(entry.conditions, GEA.getOption(a[i]), entry) 
            else 
              GEA.insert(entry.actions, GEA.getOption(a[i]), entry) 
            end
          end
      else
          if (type(a, "table") and a[1]:lower()=="if") then 
            GEA.insert(entry.conditions, GEA.getOption(a[2]), entry) 
          elseif (type(a, "table") and GEA.compareString(a[1]:lower(), "#r#^time|dates|days|dst|nodst|^armed|^disarmed")) then 
            GEA.insert(entry.conditions, GEA.getOption(a), entry) 
          else 
            GEA.insert(entry.actions, GEA.getOption(a), entry) 
          end
      end
    end
        
    local correct = true
    local erreur = ""
    GEA.currentEntry = entry
    if (GEA.source["type"] == "autostart") then 
      for i = 1,  #entry.conditions do
        entry.log = tools.iif(l, entry.log, entry.log .. entry.conditions[i].getLog())
        GEA.currentMainId = entry.mainid
        GEA.currentCondition = entry.conditions[i]
        check, msg = entry.conditions[i].control()
        if (not check) then erreur = msg end
        if (not entry.conditions[i].hasValue) then 
          check = false
          erreur = string.format(GEA.trad.not_an_condition, entry.conditions[i].getLog())
        end
        correct = correct and check
      end
      entry.log = tools.iif(l, entry.log, entry.log .. " | " .. entry.duration .. " | " .. tools.cut(entry.message) .. tools.iif(#entry.actions>0, " | ", " | " .. GEA.trad.no_action))
      for i = 1,  #entry.actions do
        entry.log = tools.iif(l, entry.log, entry.log .. entry.actions[i].getLog())
        GEA.currentAction = entry.actions[i]
        check, msg = entry.actions[i].control()
        if (not check) then erreur = msg end
        if (not entry.actions[i].hasAction) then 
          check = false
          erreur = string.format(GEA.trad.not_an_action, entry.actions[i].getLog())
        end      
        correct = correct and check
      end
    end
    entry.log = entry.log .."<span style=\"color:gray;\">" .. tools.iif(entry.repeating, " *"..GEA.trad.repeated.."*", "") .. tools.iif(entry.stopped, " *"..GEA.trad.stopped.."*", "") .. tools.iif(entry.maxtime > 0, " *"..GEA.trad.maxtime.."="..entry.maxtime.."*", "") .. "</span>"
        
    if (correct) then 
      if (GEA.source["type"] == "autostart" and d<0) then return end
      if (GEA.source["type"] == "other") then return end
      if (GEA.source["type"] ~= "autostart" and d>=0) then return end    
      tools.info(tools.iif(entry.duration < 0, GEA.trad.add_event .." ", GEA.trad.add_auto .." ") .. entry.log) 
    else 
      tools.error(tools.iif(entry.duration < 0, GEA.trad.add_event .." ", GEA.trad.add_auto .." ") .. entry.log) 
      tools.error(erreur) 
      tools.error(GEA.trad.gea_failed) 
      fibaro:abort()
    end
    
    table.insert(GEA.entries, entry)
    
    return entry.id
  end
  
  -- ----------------------------------------------------------
  -- Vérifie une entrée pour s'assurer que toutes les conditions 
  -- soient remplies
  -- ----------------------------------------------------------
  GEA.check = function(entry) 
    
    if (GEA.getOption({"StopTask", entry.id}).getValue()) then entry.stopped = true end
    if (GEA.getOption({"RestartTask", entry.id}).getValue()) then 
      GEA.reset(entry) 
      GEA.stoppedTasks[entry.id] = nil
      fibaro:setGlobal(GEA.globalvariables, fibaro:getGlobalValue(GEA.globalvariables):gsub("|R_" .. entry.id, ""))
      fibaro:setGlobal(GEA.globalvariables, fibaro:getGlobalValue(GEA.globalvariables):gsub("|M_" .. taskid .. "{(%d+)}", ""))
    end

    if (entry.stopped) then 
      if (not GEA.stoppedTasks[entry.id]) then tools.debug("@" ..(GEA.nbRun*GEA.checkEvery) .. "s ["..GEA.trad.stopped.."] " .. entry.log) end
      GEA.stoppedTasks[entry.id] = true
    end
    
    -- test des conditions
    local ready = true
    for i = 1, #entry.conditions do 
      GEA.currentCondition = entry.conditions[i]
      local result, _ = entry.conditions[i].check() 
      ready = ready and result
    end    
    
    if (not entry.stopped) then tools.debug("@" ..(GEA.nbRun*GEA.checkEvery) .. "s ["..GEA.trad.validate..tools.iif(ready, "*] ", "] ") .. entry.log) end
    
    if (ready) then
      if (entry.stopped) then return end
      entry.count = entry.count + 1
      if (tools.isNil(entry.lastvalid)) then entry.lastvalid = os.time() end
      if (os.difftime(os.time(), entry.lastvalid) >= entry.duration) then
        tools.info("@" ..(GEA.nbRun*GEA.checkEvery) .. "s [Démarrage] " .. entry.log)
        -- gestion des actions
        for i = 1, #entry.actions do
          GEA.currentAction = entry.actions[i]
          tools.debug("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;["..GEA.trad.action.."] " .. entry.actions[i].getLog())
          if (GEA.secureAction) then
            if (not pcall( function() entry.actions[i].action() end ) ) then tools.error(GEA.trad.err_check .. entry.actions[i].getLog()) end
          else
            entry.actions[i].action()
          end
        end
        -- envoi message push
        if (entry.message ~= "") then if (type(GEA.output)~="function") then for i = 1, #entry.portables do GEA.getOption({"Portable", entry.portables[i], GEA.getMessage()}).action() end else GEA.output(GEA.getMessage()) end end
        entry.lastvalid = os.time()
        entry.runned = true
        -- mise à jour des écoutes --
        for i=1, #entry.listeners do GEA.findEntry(entry.listeners[i]).isWaiting[entry.id] = false end
        -- remise à zéro des attente --
        for i=1, #entry.isWaiting do entry.isWaiting[i] = true end
        -- Vérification du MaxTime
        if (entry.maxtime > 0) then
          local time = GEA.options.maxtime.getValue(entry.id)
          if (not time) then 
            GEA.options.maxtime.action(entry.id, entry.maxtime-1)
          else
            if (tonumber(time) <= 1) then
              GEA.options.stoptask.action(entry.id)
              fibaro:setGlobal(GEA.globalvariables, fibaro:getGlobalValue(GEA.globalvariables):gsub("|M_" .. taskid .. "{(%d+)}", ""))
            else
              GEA.options.maxtime.action(entry.id, time-1)
            end
          end
        end
        if (not entry.repeating) then entry.stopped = true end
      end
    else
      GEA.reset(entry)
    end
    return ready
  end
  
  -- ----------------------------------------------------------
  -- Remplace les éléments du message
  -- ----------------------------------------------------------
  GEA.getMessage = function(message)
    if (not message) then message = GEA.currentEntry.message end
    message = tostring(message)
    message:gsub("(#.-#)", function(c) 
        local position = tonumber(c:match("%[(%d+)%]") or 1)
        c = c:gsub("%[","%%%1"):gsub("%]","%%%1")
        if (c:find("value")) then message = message:gsub(c, tostring(GEA.currentEntry.conditions[position].lastvalue)) end
        if (c:find("name")) then message = message:gsub(c, GEA.currentEntry.conditions[position].getModuleName()) end
        if (c:find("room")) then message = message:gsub(c, GEA.currentEntry.conditions[position].getModuleRoom()) end
    end)
    message = message:gsub("#runs#", GEA.nbRun)
    message = message:gsub("#seconds#", GEA.checkEvery)
    local now = os.time()
    local duree, dureefull = GEA.getDureeInString(os.difftime(now, now-((GEA.currentEntry.count-1)*GEA.checkEvery)))
    message = message:gsub("#duration#", duree)
    message = message:gsub("#durationfull#", dureefull)
    message = message:gsub("#time#", os.date(GEA.trad.hour_format))
    message = message:gsub("#date#", os.date(GEA.trad.date_format))
    return message
  end

  -- ----------------------------------------------------------
  -- Recherche et activation des plugins scénarios
  -- ----------------------------------------------------------
  GEA.searchPlugins = function()
    if (GEA.source.type ~= "autostart") then
      GEA.plugins = json.decode(fibaro:getGlobalValue(GEA.pluginsvariables))
      for k, v in pairs(GEA.plugins) do GEA.options[k] = GEA.copyOption(GEA.options.pluginscenario, k) end
      return
    end
    local message = GEA.trad.search_plugins.." :"
    local scenes = api.get("/scenes")
    local found = false
    for i = 1, #scenes do
      if (scenes[i].isLua) then
        local scene = api.get("/scenes/"..scenes[i].id)
        if (string.match(scene.lua, "GEAPlugin%.version.?=.?(%d+)")) then
          local name = scene.name:lower():gsub("%p", ""):gsub("%s", "")
          message = message .. " " .. name
          GEA.plugins[name] = scene.id
          GEA.options[name] = GEA.copyOption(GEA.options.pluginscenario, name)
          found = true
          if (tools.isNil(fibaro:getGlobalValue(GEA.pluginsvariables))) then 
            tools.info(string.format(GEA.trad.gea_global_create, GEA.pluginsvariables), "yellow")
            api.post("/globalVariables", {name=GEA.pluginsvariables, isEnum=0}) 
          end
          fibaro:setGlobal(GEA.pluginsvariables, json.encode(GEA.plugins))
        end
      end
    end
    if (not found) then message = message .. GEA.trad.plugins_none end
    tools.info(message, "yellow")
  end
  
  -- ----------------------------------------------------------
  -- RAZ d'une entrée
  -- ----------------------------------------------------------
  GEA.reset = function(entry)
      entry.count = 0
      entry.lastvalid = nil
      entry.stopped = false
      entry.runned = false
  end
  
  -- ----------------------------------------------------------
  -- Lance le contrôle de toutes les entrées
  -- ----------------------------------------------------------
  GEA.nbRun = -1
  GEA.currentMainId = nil
  GEA.currentEntry = nil
  GEA.run = function() 
    if (GEA.source.type == "autostart") then setTimeout(function() GEA.run() end, GEA.checkEvery * 1000) end
    GEA.nbRun = GEA.nbRun + 1
    local diff = os.difftime(os.time(), GEA.started)
    if (GEA.nbRun > 0 and math.fmod(GEA.nbRun, 10) == 0) then tools.info(string.format(GEA.trad.gea_run_since, GEA.getDureeInString(diff))) else if (not GEA.debug) then tools.log(string.format(GEA.trad.gea_check_nbr, GEA.nbRun), "cyan", true) end end
    for i = 1, #GEA.entries do
      GEA.currentMainId = GEA.entries[i].mainid
      GEA.currentEntry = GEA.entries[i]
      GEA.check(GEA.entries[i])
    end
  end
  
  -- ----------------------------------------------------------
  -- Initialisation, démarrage de GEA
  -- ----------------------------------------------------------
  GEA.init = function()
    if (api) then GEA.language = api.get("/settings/info").defaultLanguage end
    if (not GEA.traduction[GEA.language]) then GEA.language = "en" end
    config()
    GEA.trad = GEA.traduction[GEA.language]
    if (type(GEA.portables) ~= "table") then GEA.portables = {GEA.portables} end
    if (GEA.source.type == "autostart") then
      tools.info("--------------------------------------------------------------------------------", "cyan")
      tools.info(string.format(GEA.trad.gea_start, GEA.version, GEA.source.type), "cyan")
      tools.info("--------------------------------------------------------------------------------", "cyan")
      tools.info(string.format(GEA.trad.gea_minifier, tools.version), "yellow")    
      tools.info(string.format(GEA.trad.gea_check_every, GEA.checkEvery), "yellow")
      tools.info(string.format(GEA.trad.gea_global_create, GEA.globalvariables), "yellow")
    end
    tools.info("--------------------------------------------------------------------------------")
    if (GEA.source.type ~= "autostart") then
      local var = ""
      if (GEA.source.type == "global") then
        var = GEA.source.name
      elseif (GEA.source.type == "property") then 
        var = GEA.source.deviceID
      elseif (GEA.source.type == "event") then
        var = GEA.source.event.data.id
      end
      tools.info(string.format(GEA.trad.gea_start_event, GEA.version, GEA.source.type, var), "cyan") 
    end
    GEA.searchPlugins()
    tools.info(GEA.trad.gea_load_usercode, "yellow")
    tools.info("--------------------------------------------------------------------------------")
    if (__fibaroSceneId) then
      if (tools.isNil(fibaro:getGlobalValue(GEA.globalvariables))) then api.post("/globalVariables", {name=GEA.globalvariables, isEnum=0}) end
      if (GEA.source.type == "autostart") then fibaro:setGlobal(GEA.globalvariables, "") end
    end
    setEvents()
    tools.isdebug = GEA.debug
    if (#GEA.entries==0) then tools.warning(GEA.trad.gea_nothing) end
    tools.info("--------------------------------------------------------------------------------")
    GEA.control = false
    GEA.started = os.time()
    if (#GEA.entries>0) then
      if (GEA.source.type == "autostart") then tools.info(string.format(GEA.trad.gea_start_time, os.date(GEA.trad.date_format), os.date(GEA.trad.hour_format))) end
      GEA.run()
    else
      if (GEA.source.type == "autostart") then 
        tools.info(GEA.trad.gea_stopped_auto) 
        fibaro:abort()
      end
    end
  end

end

-- ==========================================================
-- M A I N ... démarrage de GEA
-- ==========================================================
GEA.init()
