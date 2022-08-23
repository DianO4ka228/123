--Update: Îáíîâèë ïîçûâíûå/ñîñòàâ
-- Èíôîðìàöèÿ î ñêðèïòå
script_name('«Auto-Doklad»') 		                    -- Óêàçûâàåì èìÿ ñêðèïòà
script_version(3.23) 						            -- Óêàçûâàåì âåðñèþ ñêðèïòà / FINAL
script_author('Henrich_Rogge', 'Marshall_Milford', 'Andy_Fawkess') 	-- Óêàçûâàåì èìÿ àâòîðà

-- Áèáëèîòåêè
require 'lib.moonloader'
require 'lib.sampfuncs'
local dlstatus = require('moonloader').download_status


-- Ïîçûâíûå
local nicks = { -- [''] = '',
-- 12+
  ['Yupi_Mean'] = 'Þïèê', -- Ïîëêîâíèê.
  ['Andrew_Evonzer'] = 'Ãëèíîìåñ', -- Ïîëêîâíèê.
  ['Grace_Osborn'] = 'Âäîâà', -- Ïîëêîâíèê.
  ['Emma_Cooper'] = 'Ìàòü', -- Ïîäïîëêîâíèê.
  ['Wurn_Linkol'] = 'Äàðêõîëì', -- Ïîäïîëêîâíèê.
  ['Kirill_Magomedov'] = 'Ìàãà', -- Ìàéîð.

-- Êîì. ñîñòàâ.
   --Êóðàòîð.
  ['Foxit_Makayonok'] = 'Ëèñ', -- Êîìàíäèð.
  ['Satoshi_Sapporo'] = 'Ñàòî', -- Çàì. Êîìàíäèðà.
  ['Alex_Frank'] = 'Íåìåö', -- Çàì. Êîìàíäèðà.
  ['Martin_Twix'] = 'Ðàññâåò', -- Èíñòðóêòîð.
  ['Charles_Spaze'] = '×àðëè', -- Èíñòðóêòîð.
  ['Maurice_Spaze'] = 'Ìàðóñÿ', -- Èíñòðóêòîð.
  ['Nika_Black'] = 'Áàãèðà', -- Èíñòðóêòîð.
  
-- Áîéöû.
  ['Cherry_Maybach'] = 'Âèøíÿ',
  ['Sofa_Meow'] = 'Êèñà',
  ['Max_Meow'] = 'Êîò',
  ['Ayanxkoji_Omalley'] = 'Ìîëü',
  ['Ashley_Spaze'] = 'Ñåðûé',
  ['Shannon_Spaze'] = 'Ðàìîñ',
  ['Cameron_Wayne'] = 'Çåðî',
  ['Lautaro_Spaze'] = 'Êàïðàë', 
  ['Chloe_Spaze'] = 'Ñîëíöå',
  ['Carlos_Yeti'] = 'Òèêòàê',
  ['Jeremy_Spaze'] = 'Ôðîñò',
  ['Alex_Beasley'] = 'Áèñëÿ',
  ['Amanda_Ray'] = 'Òîðòèê',
  ['Jacob_Washington'] = 'Êîôå',
  ['Sky_Sillence'] = 'Òàåðî',
  ['Hawii_Tearz'] = 'Øàõà',
  
-- Ñòàæåðû.
  ['Siegmund_Berg'] = 'Çîää',
  ['Aiden_Florestino'] = 'Ïðèçðàê',
  ['Anthony_Diez'] = 'Ìåäâåäü',
  ['Sergey_Fibo'] = 'Ïàíäà',
  ['Kwenyt_Hokage'] = 'Ñêîðïèîí',
  -- [''] = '',
  -- [''] = '',
  -- [''] = '',
  -- [''] = '',
  -- [''] = '',
  
  
-- Ðåçåðâ
  ['Andy_Fawkess'] = 'Åíîò',
  ['Ayanxkoji_Omalley'] = 'Ìîëü'
}

function main()
  
  -- Ïðîâåðÿåì çàãðóæåí ëè sampfuncs è SAMP åñëè íå çàãðóæåíû - âîçâðàùàåìñÿ ê íà÷àëó
	if not isSampfuncsLoaded() or not isSampLoaded() then return end
  -- Ïðîâåðÿåì çàãðóæåí ëè SA-MP
	while not isSampAvailable() do wait(100) end
  -- Ñîîáùàåì îá çàãðóçêå ñêðèïòà
  stext('Ñêðèïò óñïåøíî çàãðóæåí!')
  
  -- Ðåãèñòðèðóåì êîìàíäó
  sampRegisterChatCommand('dok', cmd_dok)
  -- Ïðîâåðÿåì çàø¸ë ëè èãðîê íà ñåðâåð
	while not sampIsLocalPlayerSpawned() do wait(0) end
	-- Ïðîâåðêà íà àâòîçàãðóçêó.
  updateScript()
  -- Áåñêîíå÷íûé öèêë äëÿ ïîñòîÿííîé ðàáîòû ñêðèïòà
  while true do
    wait(0)
  end
end



function cmd_dok(args)
  local info = {}
  if isCharInAnyCar(PLAYER_PED) then
    if #args ~= 0 then
      local mycar = storeCarCharIsInNoSave(PLAYER_PED)
      for i = 0, 999 do
        if sampIsPlayerConnected(i) then
          local ichar = select(2, sampGetCharHandleBySampPlayerId(i))
          if doesCharExist(ichar) then
            if isCharInAnyCar(ichar) then
              local icar = storeCarCharIsInNoSave(ichar)
              if mycar == icar then
                local nicktoid = sampGetPlayerNickname(i)
                if nicks[nicktoid] ~= nil then
                  local call = nicks[nicktoid]
                  table.insert(info, call)
                else
                  local nick = string.gsub(sampGetPlayerNickname(i), "(%u+)%l+_(%w+)", "%1.%2")
                  table.insert(info, nick)
                end
              end
            end
          end
        end
      end
      if #info > 0 then
        sampProcessChatInput(string.format('/r 10-%s, %s.', args, table.concat(info,', ')))
      else
        sampProcessChatInput(string.format('/r 10-%s, solo.', args))
      end
    else
      atext('{808080}Èíôîðìàöèÿ | {FFFFFF}Ââåäèòå: /dok òåí-êîä.')
      return
    end
  else
    atext('{808080}Îøèáêà | {FFFFFF}Âû íå ñèäèòå â òðàíñïîðòå.')
    return
  end
end

-- «Auto-Report» text
function stext(text)
  sampAddChatMessage((' %s {FFFFFF}%s'):format(script.this.name, text), 0xABAFDE)
end

-- » text
function atext(text)
	sampAddChatMessage((' » {FFFFFF}%s'):format(text), 0xABAFDE)
end

-- Àâòî-îáíîâëåíèå
function updateScript()
	local filepath = os.getenv('TEMP') .. '\\online-update.json'
	downloadUrlToFile('https://raw.githubusercontent.com/DianO4ka228/123/main/online-update.json', filepath, function(id, status, p1, p2)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			local file = io.open(filepath, 'r')
			if file then
				local info = decodeJson(file:read('*a'))
				updatelink = info.updateurl
				if info and info.latest then
					if tonumber(thisScript().version) < tonumber(info.latest) then
						lua_thread.create(function()
							print('Íà÷àëîñü ñêà÷èâàíèå îáíîâëåíèÿ. Ñêðèïò ïåðåçàãðóçèòñÿ ÷åðåç ïàðó ñåêóíä.')
							wait(300)
							downloadUrlToFile(updatelink, thisScript().path, function(id3, status1, p13, p23)
								if status1 == dlstatus.STATUS_ENDDOWNLOADDATA then print('Îáíîâëåíèå óñïåøíî ñêà÷àíî è óñòàíîâëåíî.')
								elseif status1 == 64 then print('Îáíîâëåíèå óñïåøíî ñêà÷àíî è óñòàíîâëåíî.')
								end
							end)
						end)
					else print('Îáíîâëåíèé ñêðèïòà íå îáíàðóæåíî.') end
				end
			else print('Ïðîâåðêà îáíîâëåíèÿ ïðîøëà íåóñïåøíî. Çàïóñêàþ ñòàðóþ âåðñèþ.') end
		elseif status == 64 then print('Ïðîâåðêà îáíîâëåíèÿ ïðîøëà íåóñïåøíî. Çàïóñêàþ ñòàðóþ âåðñèþ.') end
	end)
end
