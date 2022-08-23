--Update: ������� ���뢭�/��⠢
-- ���ଠ�� � �ਯ�
script_name('?Auto-Doklad?') 		                    -- ����뢠�� ��� �ਯ�
script_version(3.22) 						            -- ����뢠�� ����� �ਯ� / FINAL
script_author('Henrich_Rogge', 'Marshall_Milford', 'Andy_Fawkess') 	-- ����뢠�� ��� ����

-- ������⥪�
require 'lib.moonloader'
require 'lib.sampfuncs'
local dlstatus = require('moonloader').download_status


-- ���뢭�
local nicks = { -- [''] = '',
-- 12+
  ['Yupi_Mean'] = '����', -- ����ࠫ.
  ['Grace_Osborn'] = '�����', -- ���������.
  ['Emma_Cooper'] = '����', -- ���������.
  ['Wurn_Linkol'] = '���宫�', -- ���������.
  ['Cross_Dacota'] = '�ࠪ�', -- ������������.
  ['Vlad_Werber'] = '', -- �����.

-- ���. ��⠢.
  ['Alex_Frank'] = '�����', --�����.
  ['Sergey_Fibo'] = '�����', -- ��������.
   -- ���. ��������.
  ['Suetlan Zelimxanov'] = '���', -- ���. ��������.
  ['Sky_Sillence'] = '����', -- ��������.
  ['Kwenyt_Hokage'] = '���௨��', -- ��������.
  ['Blayzex_Stoun'] = '������', -- ��������.
  
-- �����.
  ['Foxit_Makayonok'] = '���',
  ['Hawii_Tearz'] = '���',
  ['Aiden_Florestino'] = '�ਧࠪ',
  ['Anthony_Diez'] = '�������',
  ['Ashton_Beasley'] = '���',
  ['Dini_Raksize'] = '����',
  ['Comtonia_Oceguera'] = '������',
  ['Makar_Ryabov'] = '���',
  ['Sibewest_Silence'] = '����',
  ['Suleyman_Zelimxanov'] = '�������',
  ['Azim_Kenes'] = '���⮬',
  ['Till_Cunningham'] = '���',
  ['Chris_Ludvig'] = '����',
  ['Jason_Storm'] = '���',
  
-- �⠦���.
  ['Calvin_Espinozzi'] = '�����',
  ['Henry_Markano'] = '����',
  ['Sofiya_Murphy'] = '�����',
  ['Candy_Dope'] = '���⠧�',
  ['Gabriel_Olimpov'] = '���',
  ['Near_Alpinstar'] = '���ᨪ',
  ['Shane_Prix'] = '�૨�',
  ['Aleks_Bichovski'] = '��⠩',
  ['Salazar_Black'] = '�����',
  ['Jo_Bax'] = '����'
}

function main()
  
  -- �஢��塞 ����㦥� �� sampfuncs � SAMP �᫨ �� ����㦥�� - �����頥��� � ��砫�
	if not isSampfuncsLoaded() or not isSampLoaded() then return end
  -- �஢��塞 ����㦥� �� SA-MP
	while not isSampAvailable() do wait(100) end
  -- ����頥� �� ����㧪� �ਯ�
  stext('��ਯ� �ᯥ譮 ����㦥�!')
  
  -- ��������㥬 �������
  sampRegisterChatCommand('dok', cmd_dok)
  -- �஢��塞 ���� �� ��ப �� �ࢥ�
	while not sampIsLocalPlayerSpawned() do wait(0) end
	-- �஢�ઠ �� ��⮧���㧪�.
  updateScript()
  -- ��᪮���� 横� ��� ����ﭭ�� ࠡ��� �ਯ�
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
      atext('{808080}���ଠ�� | {FFFFFF}������: /dok ⥭-���.')
      return
    end
  else
    atext('{808080}�訡�� | {FFFFFF}�� �� ᨤ�� � �࠭ᯮ��.')
    return
  end
end

-- ?Auto-Report? text
function stext(text)
  sampAddChatMessage((' %s {FFFFFF}%s'):format(script.this.name, text), 0xABAFDE)
end

-- ? text
function atext(text)
	sampAddChatMessage((' ? {FFFFFF}%s'):format(text), 0xABAFDE)
end

-- ���-����������
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
							print('��砫��� ᪠稢���� ����������. ��ਯ� ��१���㧨��� �१ ���� ᥪ㭤.')
							wait(300)
							downloadUrlToFile(updatelink, thisScript().path, function(id3, status1, p13, p23)
								if status1 == dlstatus.STATUS_ENDDOWNLOADDATA then print('���������� �ᯥ譮 ᪠砭� � ��⠭������.')
								elseif status1 == 64 then print('���������� �ᯥ譮 ᪠砭� � ��⠭������.')
								end
							end)
						end)
					else print('���������� �ਯ� �� �����㦥��.') end
				end
			else print('�஢�ઠ ���������� ��諠 ���ᯥ譮. ����᪠� ����� �����.') end
		elseif status == 64 then print('�஢�ઠ ���������� ��諠 ���ᯥ譮. ����᪠� ����� �����.') end
	end)
end
