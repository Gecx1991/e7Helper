path = {}

path.��Ϸ��ʼ = function ()
	path.��Ϸ��ҳ()
	path.�������()
end

-- isBack: ͨ����back������
path.��Ϸ��ҳ = function ()
	current_server = getUIRealValue('������', '������')
	isBack = true
	if not sAppIsRunning(current_server) or not sAppIsFront(current_server) then
		isBack = false
		open(server_pkg_name[current_server])
	end
	setControlBarPosNew(0, 1)
	local clickTarget = {'����ǩ����������', '����ǩ����������2', '��������X',
											 '������¼����ʷʫ', '��������ս��', '��������',
											 '���������̵�ȡ��'}
	if wait(function ()
		-- ������ά����
		if findOne('����������ά����') then return 'exit' end
		if findOne('������ҳRank') and not longAppearMomentDisAppear('������ҳRank', nil, nil, 1) then
			return 1
		end
		if not findTapOnce(clickTarget, {keyword = {'����'}}) then
			if not isBack then
				stap(point.����)
			else
				back()
			end
		end
	end, .5, 7 * 60) == 'exit' then
		slog('������ά����...')
		exit()
	end
end

path.������� = function ()
	local allTask = table.filter(ui_option.����, function (v)
		return not v:includes({'����ǩ��',
		'���Ž���',
		'���ž���'})
	end)
	local curTaskIndex = sgetNumberConfig("current_task_index", 0)
	for i,v in pairs(allTask) do
		if i > curTaskIndex and current_task[v] then
			-- 0 ��ʾ�쳣
			-- 1 ���� nil ��ʾ ok
			-- 2 ��ʾ����
			if path[v]() == 2 then path.��Ϸ��ҳ() path[v]() end
			slog(v)
			setNumberConfig("exception_count", 1)
			path.��Ϸ��ҳ()
		end
		setNumberConfig('current_task_index', i)
	end
end

path.���ſ��� = function ()
	wait(function ()
		stap(point.����)
				ssleep(1)
			if not findOne('������ҳRank') then return 1 end
	end)
	wait(function ()
		if findOne('����������ʿ��') then ssleep(1) return 1 end
		stap({447,47})
	end)
	
	if current_task.����ǩ�� then path.����ǩ��() end
	if current_task.���ž��� then path.���ž���() end
	if current_task.���Ž��� then path.���Ž���() end
	
end

path.����ǩ�� = function ()
	if findTap('������ʿ��ǩ��') then
		wait(function ()
			stap({509,35})
			if findOne('����������ʿ��') then return 1 end
		end)
	end
end

path.���ž��� = function ()
	wait(function ()
		stap({1090,414})
		if findOne("500|130|FFFFFF,513|121|FFFFFF,520|132|FFFFFF,544|128|FFFFFF,538|137|FFFFFF") then
			return 1
		end
	end)
	-- ���
	-- ����֤��
	-- ������
	local giveType = current_task.���ž�������
	if giveType == 0 then
		findTap('������Ҿ���')
	elseif giveType == 1 then
		findTap('��������֤�ݾ���')
	elseif giveType == 2 then
		findTap('������Ҿ���')
		wait(function ()
			stap({515,40})
			if findOne('����������ʿ��') then return 1 end
		end)
		findTap('��������֤�ݾ���')
	end
	wait(function ()
		stap({515,40})
		if findOne('����������ʿ��') then return 1 end
	end)
end

path.���Ž��� = function ()
	wait(function ()
		stap({1114,698})
		if findOne('������ʿ��ÿ������', {sim = 1}) then return 1 end
	end)
	-- �Ϸ�С��㴦��, ���ʶ���...���Թ���
	if findTap('����ÿ��ÿ��С����', {rg = {437,140,987,212}, sim = .98}) then
		wait(function ()
			stap({600,81})
			if findOne('������ʿ��ÿ������', {sim = 1}) then return 1 end
		end)
	end
	-- �м���ȡ����
	-- ����ֻ�û���һ��, Ҳ����ֻ����ҳ
	for i=1,2 do
		wait(function ()
			if findTap('������ʿ��������ȡ', {rg = {866,255,990,722}}) then
				wait(function ()
					stap({424,30})
					if findOne('������ʿ��ÿ������', {sim = 1}) then return 1 end
				end)
			else
				return 1
			end
		end)
		if i == 1 then sswipe({574,674}, {574,287}) ssleep(.5) end
	end
end

-- mumu12ģ���������, ��ʱ��ű����ִ�еĺ�����
-- ���������波����?(���������һ���Ѿ������, ����ҳ��û�ж���)
-- ����mumu6������
path.ˢ��ǩ = function (rest)
	rest = rest or 0
	setNumberConfig("is_refresh_book_tag", 1)
	path.��Ϸ��ҳ()
	local tapPoint1 = point['�����̵�0']
	local tapPoint2 = point['�����̵�1']
	wait(function ()
		stap(tapPoint1)
		stap(tapPoint2)
		ssleep(1)
		if not findOne('������ҳRank') then return 1 end
	end)
	log('���������̵�')
	untilAppear('���������̵���������')
	untilAppear('���������̵��һ����Ʒ') ssleep(.5)
	-- ��ʼ�һ�ˢ����ǩ��
	-- ���������̵�������ǩ
	-- ���������̵���Լ��ǩ
	local target = {}
	local g1 = sgetNumberConfig("g1", 0)
	local g2 = sgetNumberConfig("g2", 0)
	local g3 = sgetNumberConfig("g3", 0)
	-- [���������̵����ؽ��� ���������̵���Լ��ǩ]  �ᵼ��������?
	if current_task['���ؽ���'] then table.insert(target, '����') end
	if current_task['��Լ��ǩ'] then table.insert(target, '��ǩ') end
	if current_task['������ǩ'] then table.insert(target, '���������̵�������ǩ') end
	local refreshCount = current_task['���´���'] or 334
	local enoughResources = true
	local msg
	for i=1,refreshCount do
		if i > rest then
			for i=1,4 do
				-- ���ܻ��������, ���ƶȲ�����?
				-- ��һ�����ػ�©��? todo
				local pos, countTarget = findOne(target, {rg = {540,70,669,718}})
				if pos then
					local newRg = {1147, pos[2] - 80, 1226, pos[2] + 80}
					untilTap('���������̵깺��', {rg = newRg})
					untilTap('���������̵깺��1')
					-- �ȴ�������Ч��ʧ
					wait(function ()
						if not longAppearMomentDisAppear({'���������̵���������', '���������̵깺����Դ����', '����һ���̵�'}, nil, nil, 1.5) then return 1 end
					end)
				end
				-- ��Դ�Ƿ�ľ�
				wait(function ()
					local r1, r2 = findOne({'���������̵깺����Դ����', '���������̵���������', '����һ���̵�'}, {sim = 1})
					if r2 == '���������̵���������' then
						-- ͳ�ƻ����Ʒ����
						if countTarget then
							if countTarget == '����' then
								g1 = g1 + 1
								setNumberConfig("g1", g1)
							elseif countTarget == '��ǩ' then
								g2 = g2 + 1
								setNumberConfig("g2", g2)
							elseif countTarget == '���������̵�������ǩ' then
								g3 = g3 + 1
								setNumberConfig("g3", g3)
							end
						end
						return 1 
					end
					if r2 == '���������̵깺����Դ����' or r2 == '����һ���̵�' then 
						-- ��ʾ�ж���û������
						enoughResources = false
						if countTarget then
							local curTagName = countTarget:split('�̵�')[2]
							slog('��Ҳ��㵼��, ����Ʒû�й���ɹ�: '..curTagName)
						end
						return 1 
					end
				end)
				-- д���ж������ܻ�connection���»���ʧЧ
				if i == 2 and enoughResources then
					wait(function ()
						if findOne({'���������̵�ڶ�����Ʒ',
												'���������̵��������Ʒ',
												'���������̵���ĸ���Ʒ'}, {sim = .99}) then
							return 1
						end
						sswipe({858,578}, {858,150})
					end)
				end
			end
			msg = 'ˢ�´���: '..i..'/'..refreshCount..'(���ؽ���: '..g1..'*50, ��Լ��ǩ: '..g2..'*5, ������ǩ: '..g3..'*5)'
			if not enoughResources then
				log('��Դ�ľ�!')
				slog('��Դ�ľ�!')
				-- untilTap('���������̵�ȡ��')
				path.��Ϸ��ҳ()
				break
			end
			-- ˢ�´���: 1 (���ؽ���: 5*5, ��Լ��ǩ: 10*5, ������ǩ: 20*5)
			log(msg)
			slog(msg, nil, true)
			if i == refreshCount then
				path.��Ϸ��ҳ()
				break
			end
			-- ������粻�ûᵼ�����ε��, �ĳ� sim = 1
			untilTap('���������̵���������', {sim = 1})
			untilTap('���������̵깺��ȷ��')
			untilAppear('���������̵��һ����Ʒ', {sim = .98}) ssleep(.5)
			setNumberConfig("exception_count", 1)
		end
		setNumberConfig("refresh_book_tag_count", i)
	end
	slog(msg, nil, true)
end

path.ˢ������ = function ()
	local type = current_task.����������
	if type == 0 then
		path.���������()
	elseif type == 1 then
		path.������NPC()
	elseif type == 2 then
		path.������NPC()
		path.��Ϸ��ҳ()
		path.���������()
	end
end

path.��������� = function ()
	wait(function ()
		stap(point.������)
				ssleep(1)
			if not findOne('������ҳRank') then return 1 end
	end)
	untilTap('����������')
	local r1, r2
	wait(function ()
		stap({386,17})
		r1, r2 = findOne({'�������������÷�����', 
											'����������ÿ�ܽ���ʱ��', 
											'����������ÿ����������'})
		if r1 then return 1 end
	end)
	if r2 == '����������ÿ�ܽ���ʱ��' then
		slog('������ÿ�ܽ���ʱ���˳�')
		return
	end
	if r2 == '����������ÿ����������' then
		slog('��������ȡÿ����������')
		local rankIndex = current_task['������ÿ�ܽ���'] or 0
		local pos = point.����������ÿ�ܽ���[rankIndex + 1]
		wait(function ()
			stap(pos)
			if findOne(point.����������ÿ�ܽ����ж�[rankIndex + 1]) then return 1 end
		end)
		untilTap({'������������ȡÿ�ܽ���', 'cmp_���ʷ���������ȡÿ�ܽ���'})
	end
	log('���뾺����')
	-- ��������
	-- ���˻���
	local privatePoints = untilAppear('�������������˻���', {keyword = {'����', '��', '��'}})
	privatePoints = getArenaPoints(privatePoints[1].text)
	-- log(privatePoints)
	-- ��ս�����л�
	wait(function ()
		stap({1108,116})
		if findOne({'������������ս', 
								'�����������ٴ���ս', 
								'��������������ս������'}, 
								{rg = {879,146,990,686}}) then
			ssleep(1)
			return 1
		end
	end, .5)
	-- ˢ�¶��ֵ������
	local refreshCount = current_task['��ս����']
	-- �����л���ս���ִ��������
	local buyChangeCount = true
	wait(function ()
		wait(function ()
			findTap('������������ս����')
			stap({323,27})
			if findOne('��������������λ��') then return 1 end
		end)
		-- ���˻���
		local enemyPointsInfo = untilAppear('�������������˻���')
		-- ���˷ǵ��˻���; ���˻���ת��������
		enemyPointsInfo = table.filter(enemyPointsInfo, function (v)
			if v.text:find('����') or v.text:find('��') or v.text:find('��') then
				local tmp, isChallenge = untilAppear({'��������������ս������', '������������ս',
				'�����������ٴ���ս'}, {rg = {886, v.t - 50, 990, v.b + 50}})
				if isChallenge == '������������ս' then v.text = getArenaPoints(v.text) return 1 end
			end
		end)
		-- log(enemyPointsInfo)
		-- ������Ҫ��: С�ڸ��˻��־���
		local finalPointsInfo = table.filter(enemyPointsInfo, function (v) return v.text < privatePoints end)
		-- û��С���Լ���
		-- Ҫô�ֶ����ѽ��ˢ�£�Ҫô�ȴ�ˢ��8����
		if #finalPointsInfo == 0 then
			if buyChangeCount then
				local result = untilAppear('����ˢ����ս', {keyword = {'���', 'ʣ��ʱ��', 'ʱ��', 'ʣ��'}})[1]
				untilTap('����ˢ����ս')
				if result.text:includes({'ʣ��ʱ��', 'ʣ��', 'ʱ��'}) then
					local availableRefreashCount = math.floor(getArenaPoints(untilAppear('������������ս����ʣ��ˢ�´���')[1].text) / 100)
					if refreshCount == 0 then
						slog('���ָ�������������!')
						untilTap('����������ȡ����������')
						return 1
					end
				end
				untilTap('�����������л�����ȷ��')
				refreshCount  = refreshCount - 1
				-- ����Ƿ�ľ�
				local tmp, v = untilAppear({'���������̵깺����Դ����', '�������������÷�����'})
				if v == '���������̵깺����Դ����' then log('��Դ����') untilTap('���������̵�ȡ��') return 1 end
				-- ���������, ��ʼ�µ�һ��
				return
			else
				log('�޵����Լ�����')
				return 1
			end
		end
		finalPointsInfo = finalPointsInfo[1]
		untilTap('������������ս', {rg = {886, finalPointsInfo.t - 80, 990, finalPointsInfo.b + 80}})
		untilTap('����������ս����ʼ')
		if path.��������Ʊ() == 1 then
			return 1
		end
		path.ս������()
	end, .5, nil, true)
end

path.������NPC = function ()
	wait(function ()
		stap(point.������)
				ssleep(1)
			if not findOne('������ҳRank') then return 1 end
	end)
	wait(function ()
		if not findOne('����������') then
			return 1
		end
		stap({999,339})
	end)
	local p, v
	wait(function ()
		p, v = findOne({'����JJC���½�', 
								 '����������ÿ����������'})
		if v == '����JJC���½�' then
			return 1
		end
		if v == '����������ÿ����������' then
			slog('��������ȡÿ����������')
			local rankIndex = current_task['������ÿ�ܽ���'] or 0
			local pos = point.����������ÿ�ܽ���[rankIndex + 1]
			wait(function ()
				stap(pos)
				if findOne(point.����������ÿ�ܽ����ж�[rankIndex + 1]) then return 1 end
			end)
			untilTap('������������ȡÿ�ܽ���')
		end
	end)
	wait(function ()
		if findOne('����NPC��ս����') then
			return 1
		end
		stap({1048,216})
	end)

	local pos
	local isSwipe = 1
	while 'qqȺ206490280' do
		wait(function ()
			findTap('������������ս����')
			stap({323,27})
			if findOne('��������������λ��') then ssleep(1) return 1 end
		end)
		pos = findOne('����NPC��ս', {rg = {855,141,996,721}})
		if not pos and isSwipe == 2 then break end
		if not pos then
			isSwipe = isSwipe + 1
			wait(function ()
				sswipe({846,498}, {846,206})
				ssleep(1.5)
				if findOne('780|683|FFFFFF,774|674|FFFFFF,774|690|FADD32') then
					return 1				
				end
			end)
		else
			-- ��ʼˢNPC
			wait(function ()
				stap(pos)
				if not findOne('����JJC���½�') then return 1 end
			end)
			untilTap('����������ս����ʼ')
			-- ��Ʊ
			if path.��������Ʊ() == 1 then
				break
			end
			path.ս������()
			isSwipe = 1
		end
	end
	slog('������NPC���')
end

path.��������Ʊ = function ()
	-- Ҷ�ӹ���Ʊ
	local buyTicket = current_task['Ҷ����Ʊ']
	local t,v
	wait (function ()
		stap({615,23})
		t, v = findOne({'��������������Ʊҳ��', '����Auto'})
		if v then
			return 1
		end
	end)
	-- �Ƿ�ʹ��Ҷ�Ӷһ�5��Ʊ
	-- �Ƿ�ʹ��שʯ�һ�5��Ʊ �ݲ�֧��
	if v == '��������������Ʊҳ��' and buyTicket then
		local tmp, ticketType = untilAppear({'����������Ҷ�ӹ���Ʊ', 
																					'����������שʯ����Ʊ'})
		if ticketType == '����������Ҷ�ӹ���Ʊ' then
			log('��Ʊ')
			untilTap('��������������Ʊ')
			-- ����Ƿ���
			local tmp, v = untilAppear({'���������̵깺����Դ����',
																	'������������ս����ʼ'})
			if v == '���������̵깺����Դ����' then log('��Դ����') return 1 end
		end
		if ticketType == '����������שʯ����Ʊ' then log('ȡ����Ʊ') untilTap('����������ȡ����Ʊ') return 1 end
		untilTap('����������ս����ʼ')	
	end

	if v == '��������������Ʊҳ��' and not buyTicket then
		log('����Ʊ')
		return 1
	end
end

-- isRepeat �Ƿ�����
-- isAgent �Ƿ����
-- isActivity �Ƿ��ǻ, ���ܲ��ǲ���ֵ,���Ƿ�Χ
path.ս������ = function (isRepeat, isAgent, currentCount, isActivity)
	-- ���½�ʶ��Χ
	local rightBottomRegion = isActivity and '�������½ǻ' or '�������½�'
	log('ս����ʼ')
	-- ����auto
	if not isRepeat then
		-- untilAppear('����Auto')
		wait(function ()
			if findOne('����Auto') then
				return 1
			end
			stap({638,31})
		end)
		wait(function ()
			stap('����Auto')
			ssleep(1)
			if findOne(point.����AUto�ɹ�) then return 1 end
		end)
	end
	
	
	if isRepeat then
		wait(function ()
			if findOne('����������') then return 1 end
			ssleep(1)
			stap('����������')
		end)
	end
	
	-- �ȴ�����
	-- ÿ���޶���ʱս��Ϊ5����
	if not isRepeat then
		wait(function ()
			-- ���ֻ���һ������ǰ��ҳ, ֱ�ӵ����
			log('������.')
			-- NPC�Ի���� 
			stap({615,23})
			if findTap({'����ս����ɾ�����ȷ��', 
									'����ս�����ȷ��'}, {tapInterval = 1}) then 
				return 1
			end
		end, game_running_capture_interval, 10 * 60)
	else
		local targetKey = {'ս����ʼ', 'ȷ��', '���½���', 'ѡ�����'}
		local target = {'�������ȡ��','��������ȷ��','���������ռ䲻��', 
										'�����ж�������', '�������½�', '�������½ǻ', 
										'����ս��ʧ��', '����ս���ʺ�'} -- �������롢����������ܻ����
		local pos, targetV
		wait(function ()
			if currentCount then
				if isAgent then
					log('������-�г���: '..currentCount..'/'..global_stage_count)
				else	
					log('������-�޳���: '..currentCount..'/'..global_stage_count)
				end
			else
				log('������..')
			end
			-- ���й���Ҫ�ֶ����,���ܵ������ҳ��
			if not isAgent then stap({483,15}) end
			if ((isAgent and findOne('�����ظ�ս�����', {keyword = {'�ظ�ս���ѽ���'}})) or
				 not isAgent) and 
				 findOne({'�������½�', '����ս��ʧ��'}, {keyword = {'ȷ��', '���½���'}}) then
				wait(function ()
					pos, targetV = findOne(target, {keyword = targetKey})
					if not pos then return end
					if targetV:includes({'���������ռ䲻��', '�����ж�������', '����ս���ʺ�'}) then
						-- ��֤���ڽ���ҳ
						if targetV == '����ս���ʺ�' and findOne('����ս���������ϱ���') then
							return
						end
						return 1
					end
					if targetV:includes({'�������½�', '����ս��ʧ��'}) then
						findTap({'�������ȡ��', '��������ȷ��'}) -- �п��ܻ��������
						stap({pos[1].l, pos[1].t})
					end
					if targetV:includes({'��������ȡ��', '��������ȷ��'}) then
						stap(pos)
					end
				end)
				return 1
			end
			-- ����һЩ����
			-- if findOne('�������޼���', {sim = .9}) then stap({903,664}) end
			if findTap('�����ҵ�ͨ������') then log('���ͨ������') end
			if findTap('�������ȡ��') then log('��������ȡ��') end
			if findTap('��������ȷ��') then log('��������ȷ��') end
		end, game_running_capture_interval, isAgent and (9999 * 10 * 60) or (10 * 60)) -- �г���9999����, �޳���10����(�����п��ܻᱻre_wait_time, ��Ӱ��[˵����Ϸû�п���])
	end
	log('ս���������')
end

path.�������� = function ()
	if not findOne('��������С�ݺ��') then log('�޳�����ȡ') return end
		wait(function ()
			stap(point.����С��)
					ssleep(1)
			if not findOne('������ҳRank') then return 1 end
		end)
		untilTap('������������')
		if wait(function ()
			stap('���������������')
			if not findOne('���������������') then return 1 end
			if findOne('�������ﱳ������') then
				path.���ﱳ������()
				return 2
			end
		end) == 2 then
		return 2
	end
	-- �����ȡһ��
	wait(function ()
		stap({34,151})
		if findOne('������������') then return 1 end
	end)
end

path.�ɾ���ȡ = function ()
	if not findOne({'�����ɾͺ��', '�����ɾͺ��2'}) then log('�޳ɾ���ȡ') return 1 end
	wait(function ()
		stap(point.�ɾ�)
				ssleep(1)
			if not findOne('������ҳRank') then return 1 end
	end)
	untilAppear('���������ܷ��·���')
	local target = {'�����������ռ�', '��������֮������Ժ', '����Ԫ��Ժ', '������������', '���������Ӱ��'}
	for i,v in pairs(target) do
		local curTarget
		wait(function ()
			stap(v)
			curTarget = findOne('�����ɾ�����')
			if curTarget and v:find(curTarget[1].text) then return 1 end
		end)
		-- �������ռǱȽ�����
		if v == '�����������ռ�' then
			local targ = {'����ÿ�ճɾ�', '����ÿ�ܳɾ�'}
			local key = {{'ÿ��', '��'}, {'ÿ��', '��'}}
			for i,v in pairs(targ) do
				if findOne(v) then
					-- �л��� ÿ��/ÿ�ܵ���
					wait(function ()
						stap(v)
						if findOne('����ÿ��ÿ�ܵ���', {keyword = key[i]}) then return 1 end
					end)
					untilTap('����ÿ��ÿ��С����', {rg = {415,141,946,185}, sim = .98})
					wait(function ()
						stap({574,40})
						if findOne('���������ܷ��·���') then return 1 end
					end)
				end
			end
		else
			wait(function ()
				findTap('�����ɾ���ȡ��ɫ')
				if findOne('�����ɾ�ǰ����ɫ') then log(11) return 1 end
				stap({574,40})
			end)
		end
	end
end

path.������� = function ()
	if findOne('�����������') then untilTap('�����������') else log('�޳������') end
end

path.��ȡ�ʼ� = function ()
	if not findOne({'�����ʼ�', '�����ʼ�2'}) then log('���ʼ�') return 1 end
	wait(function ()
		stap(point.�ʼ�)
				ssleep(1)
			if not findOne('������ҳRank') then return 1 end
	end)
	untilAppear({'�����ʼ�ҳ��', '���ʷ��ʼ�'})
	wait(function ()
		stap({911,87})
		if findTap('�����ʼ���ȡȷ������') then return 1 end
	end)
	wait(function ()
		stap({563,85})
		if findOne('�����ʼ�ҳ��') then return 1 end
	end)
	-- �����޷���ȫ����ȡ��
	-- ���ܻ���װ����Ҫ����
	wait(function ()
		if not findTap('�����ʼ���ȡ�̵�') then return 1 end
		local tmp, target = untilAppear({'�����ʼ�����', '�����ʼ���ȡ����', '�����ʼ���ý���Tip',
		'�����ʼ�ҳ��', '�����ʼ���ȡӢ��ȷ��', '���������ռ䲻��'})
		if target and (target ~= '�����ʼ�ҳ��' and target ~= '���������ռ䲻��')  then untilTap(target) end
		if target and target == '���������ռ䲻��'  then
			path.��������(function () path.��ת('�����ʼ�ҳ��') end)
		end
		wait(function ()
			stap({563,85})
			findTap('�����ʼ���ȡӢ��ȷ��')
			if findOne('�����ʼ�ҳ��') then ssleep(.5) return 1 end
		end)
	end, 1, 5 * 60, nil, true)
end

path.��Լ�ٻ� = function ()
	if not findOne({'�����ٻ�С���'}) then log('����Լ�ٻ�') return 1 end
	wait(function ()
		stap(point.�ٻ�)
				ssleep(1)
			if not findOne('������ҳRank') then return 1 end
	end)
	-- Ѱ����Լ�ٻ�
	local pos, target
	wait(function ()
		sswipe({1141,588}, {1141,100})
		ssleep(1)
		pos = findOne('�����ٻ�����', {keyword = {'��Լ�ٻ�', '��Լ'}})
		if pos then return 1 end
	end)
	wait(function ()
		stap({pos[1].l, pos[1].t})
		if findOne('����10���ٻ�') then ssleep(1) return 1 end
	end)
	if findTap('�������1���ٻ�') then untilTap('�����ٻ�ȷ��') end
	wait(function ()
		stap({156,659})
		if findOne('����10���ٻ�') then return 1 end
	end)
end

path.ʥ���ղ� = function ()
	if not findOne({'����ʥ��С���'}) then log('�����ղ�') return 1 end
	wait(function ()
		stap(point.ʥ��)
			ssleep(1)
		if not findOne('������ҳRank') then return 1 end
	end)
	path.ʥ������������ȡ()
	path.ʥ����֮ɭ��ȡ()
end

path.ʥ������������ȡ = function ()
	untilAppear('����ʥ����ҳ')
	log('ŷ�ձ�˹֮�Ĵ���')
	wait(function ()
		if findTap('����ŷ�ձ�˹֮��') then
			return 1
		end
	end, .1, 1)
	wait(function ()
		stap({649,58})
		if findOne('����ʥ����ҳ') then ssleep(.5) return 1 end
	end)
end

path.ʥ����֮ɭ��ȡ = function ()
	log('����֮ɭ����')
	local target = {'����ʥ����쵰', '����ʥ����֮Ȫ', '����ʥ����ֲ��', '����ʥ����ֲ���ջ�'}
	if findTap('����ʥ����֮ɭС���') then
		-- untilAppear('��������״̬')
		wait(function ()
			stap({104,100})
			if findOne('����ʥ����쳲Ѩ') then return 1 end
		end)
		for i,v in pairs(target) do
			if wait(function () if findTap(v) then return 1 end end, 0, .5) then
				wait(function ()
					stap({104,100})
					if findOne('����ʥ����쳲Ѩ') then return 1 end
				end)
			end
		end
	end
	path.ʥ����ҳ()
end

local number = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'}
-- todo
path.ʥ��ָ���ܲ� = function ()
	log('ָ���ܲ�����')
	local target = '�ַ�'
	if findTap('����ʥ��ָ���ܲ�С���') then
		untilAppear('��������״̬')
		wait(function ()
			stap(point.ʥ��ָ���ܲ�����[target])
			if findOne('����ʥ��ָ���ܲ�����ѡ��', {keyword = {target}}) then return 1 end
		end)
		local dispatchLevel = findOne('������ǲ����ȼ�')
		local dispatchLevelSort = {'12', '8', '6', '4', '2', '1', '30'}
		if not dispatchLevel then log('����ǲ') return 1 end
		if #dispatchLevel > 1 then
			-- ���˷���ǲ�ȼ�
			dispatchLevel = table.filter(dispatchLevel,
			function (v) if v.text:includes({'����ʱ��', 'Сʱ', '��', '��'}) and
			findOne('������ǲִ��', {rg = {890, v.t, 980, v.b + 75}}) then return 1 end end)
			-- �������õȼ���ѯ������ǲlevel
			for i,v in pairs(dispatchLevelSort) do
				local result = table.findv(dispatchLevel, function (val) if val.text:includes({v}) then return 1 end end)
				if result then dispatchLevel = result break end
			end
		end
		untilTap('������ǲִ��', {rg = {890, dispatchLevel.t, 980, dispatchLevel.b + 75}})
		untilAppear('������ǲִ������')
		local needLevel = getArenaPoints(untilAppear('������ǲ����ȼ�', {keyword = {'Lw', 'L', 'v', 'w'}})[1].text)
		-- �Լ�����Ӣ������
	end
end

path.ʥ����ҳ = function ()
	wait(function ()
		if findOne('����ʥ����ҳ') then ssleep(1) return 1 end
		stap({31,32})
		ssleep(2)
	end)
end

path.�������� = function ()
	log('��������')
	wait(function ()
		stap(point.�̵�)
				ssleep(1)
			if not findOne('������ҳRank') then return 1 end
	end)
	untilAppear('����һ���̵�')
end

path.������Ԩ = function ()
	
end

path.ս��ѡ��ҳ = function ()
	wait(function ()
		stap(point.ս��)
				ssleep(1)
			if not findOne('������ҳRank') then return 1 end
	end)
	untilAppear('����ս������ҳ')
	wait(function ()
		stap({280,260})
		if not findOne('�����Թ���ҳ', {sim = 1}) then return 1 end
	end)
end

-- ˢͼ
path.ˢͼ���� = function ()
	-- ͼ����
	log('����ˢͼ')
	-- �ַ�
	local stageAll = ui_option.ս������
	local currentStage = sgetNumberConfig('current_stage', 1)
	for i,v in pairs(stageAll) do
		if current_task[v] and i >= currentStage then
			if v:includes({'�ַ�', '�Թ�', '�����̳', '��Ԩ'}) then
				path.ս��ѡ��ҳ()
				wait(function ()
					stap(point.ս��ģʽλ��[v])
					if findOne('����ս������', {keyword = cutStringGetBinWord(v)}) then return 1 end
				end)
			end
			if path[v]() ~= 0 then
				slog(v..'���')
			else
				slog(v..'δ���')
			end
			-- ����ˢͼ����
			setNumberConfig("fight_count", 0)
			sgetNumberConfig('current_stage', i)
			path.��Ϸ��ҳ()
		end
	end
end

path.ս����ͼ = function (levelTarget)
		-- ȷ�����������ϲ�
	wait(function ()
		sswipe({835,100}, {835,3000})
		ssleep(1)
		return findOne('�ؿ�����')
	end, 0)
	-- ��������
	local newTextVal
	-- ��ֵ�ظ�����
	local newTextValReCount = 0
	local curTextVal
	wait(function ()
		wait(function ()
			curTextVal = findOne('����ս������')
			if curTextVal then curTextVal = curTextVal[1].text return 1 end
		end, .05, .3)
		if curTextVal and curTextVal:find(levelTarget) then return 1 end
		if not newTextVal then
			newTextVal = curTextVal
			newTextValReCount = newTextValReCount + 1
		else
			if newTextVal == curTextVal then
				newTextValReCount = newTextValReCount + 1
			else
				newTextVal = curTextVal
				newTextValReCount = 0
			end
			if newTextValReCount == 3 then
				sswipe({835,100}, {835,3000})
				ssleep(1)
				newTextVal = nil
				newTextValReCount = 0
			end
		end
		p = findOne('���������Ȧ')
		if p then p = {p[1], p[2] + 50} stap(p) ssleep(1) end
	end, 0, 5 * 60)

	-- 0 ��ʾ��ͼ��δ���
	local selectGroup
	if not wait(function ()
		return wait(function ()
			if findTapOnce('������ѡ�����', {rg = {988,600,1278,717}}) then
				return wait(function ()
					if not findOne('������ѡ�����', {rg = {988,600,1278,717}}) then return 1 end
				end, .3, 5)
			end
		end)
	end, .5, 5) then
		log('δ�����ؿ�')
		slog('δ�����ؿ�')
		return 0
	end
end

path.ս����ͼ1 = function (typeTarget, levelTarget, fightCount, isActivity)
	-- local p
	-- local key = {'�׶�', '��̳', '����', '�ַ�'}
	-- �ؿ�
	if typeTarget then
		for i=1,3 do
			if wait(function ()
				if findTap(typeTarget, {rg = point.����ս����������, sim = .9}) then return 1 end
				swipeEndStop({834,686}, {834,300}, .3)
				ssleep(1)
			end, 1, 5) then
				break
			else
				sswipe({835,300}, {835,2000})
				ssleep(1)
			end
			if i == 3 then slog('�ؿ�����δ������ʱ��') return 0 end
		end
	end
	untilAppear('������ѡ�����', {rg = {988,600,1278,717}})

	if path.ս����ͼ(levelTarget) == 0 then
		return 0
	end

	path.ͨ��ˢͼģʽ1(fightCount, isActivity, levelTarget)
end

-- ��ͼģʽ1
-- �ַ� �����̳
-- 834,686 834,147
-- fightCount: 10
path.ͨ��ˢͼģʽ1 = function (fightCount, isActivity, levelTarget)
	global_stage_count = fightCount
	local rightBottomRegion = isActivity and '�������½ǻ' or '�������½�'
	untilAppear(rightBottomRegion, {keyword = {'ս����ʼ'}})	ssleep(.5)
	-- ��������еĻ�,�ʹ���
	local isAgent = path.�йܴ���(isActivity)
	local pos, noAct
	if wait(function ()
		pos, noAct = findOne({'���������ռ䲻��', '�����ж�������', rightBottomRegion}, {keyword = {'ս����ʼ', 'ѡ�����'}})
		if noAct == '�����ж�������' then
			slog('�ж�������')
			log('�ж�������!')
			if path.��������() == 0 then return 0 end
		end
		if noAct == '���������ռ䲻��' then return 1 end
		if noAct == rightBottomRegion then stap({pos[1].l, pos[1].t}) end
		if findOne({'����������', '����һ����'}) then return 1 end
	end) == 0  then
		return 0
	end
	local tmp, noAction
	wait(function ()
		tmp, noAction = findOne({'���������ռ䲻��', '����������', '����һ����'})
		if noAction then return 1 end
	end)

	local staticTarget = {'���������ռ䲻��', '����������', '�����ж�������', '����һ����'}

	local currentCount = sgetNumberConfig('fight_count', 1)
	while currentCount <= fightCount do
		if noAction ~= '���������ռ䲻��' then
			path.ս������(1, isAgent, currentCount, isActivity)
			log('��ɴ���: '..currentCount)
		end
		local retCode = wait(function ()
			-- ƣ������
			wait(function ()
				tmp, noAction = findOne(staticTarget)
				if noAction then return 1 end
			end)
			-- �ж���
			if noAction == '�����ж�������' then
				slog('�ж�������')
				log('�ж�������!')
				if path.��������() == 0 then return 0 end
				-- ��Ҫ�����ͼ
				wait(function ()
					if findOne(staticTarget) then
						return 1
					end
					if findOne(rightBottomRegion, {keyword = 'ս����ʼ'}) then
						stap({1150,659})
					end
				end)
			end
			-- �ж���������
			if noAction == '���������ռ䲻��' then
				-- �Ƿ��Ǻ�ǣ���ǱȽ�����, ���������ᵽ׼��ս��ҳ��
				path.��������(function ()
						wait(function ()
							stap({487,18})
							return findOne('�������ؼ�ͷ')
						end)
						if levelTarget == '���' then
							-- ��һ�β��ᵽδ���صĹ���
							local rvb, res = untilAppear({'����δ���صĹ���', '��������׼��ս��'})
							if res == '����δ���صĹ���' then
								wait(function ()
									findTapOnce('���׼��ս��')
									return wait(function ()
										if not findOne('���׼��ս��') then return 1 end
									end, .5, 5)
								end)
							end
						else
							local rvb, res = untilAppear({'���������Ȧ', '��������׼��ս��'})
							if res == '���������Ȧ' then
								path.ս����ͼ(levelTarget)
							end
						end
				end)
				-- �ٴε�������ܻ�����ֱ�������
				-- һ������: return 1
				-- �ж��������ռ䲻��: ֱ��return 0
				local pos
				local resultCode = wait(function ()
					pos = findOne(rightBottomRegion, {keyword = {'ս����ʼ', '׼��ս��', 'ѡ�����'}})
					if pos then stap({pos[1].l, pos[1].t}) ssleep(1) end
					tmp, noAction = findOne(staticTarget)
					if noAction == '����������' or noAction == '����һ����' then return 1 end
					if noAction == '�����ж�������' or noAction == '���������ռ䲻��' then return 0 end
				end)
				if resultCode == 1 then return 1 end
				if resultCode == 0 then return end
			end
			return 1
		end, 1, 5 * 60)
		if retCode == 0 then
			return 0
		end
		if retCode == 1 then
			currentCount = currentCount + 1
			setNumberConfig("fight_count", currentCount)
		end
	end
end

path.�������� = function ()
	local energyType = current_task.�����ж�������
	local targetRg = {352,237,935,456}
	local pos
	if energyType == 2 then slog('�������ж���') return 0 end
	if energyType == 0 then
		if not wait(function ()
			pos = findOne('�����ж���Ҷ��', {rg = targetRg})
			if pos then stap(pos) return 1 end
		end, .1, 3) then
		slog('δ�ܲ����ж���')
		return 0
	end
	end
	if energyType == 1 then
		-- ����Ҷ��
		-- ������Ҷ��
		if not wait(function ()
			pos = findOne({'�����ж���Ҷ��', '�����ж���שʯ'}, {rg = targetRg})
			if pos then stap(pos) return 1 end
		end) then
		slog('δ�ܲ����ж���')
		return 0
		end
	end
	-- ���ȷ��
	-- ������bug, ���Ҷ�Ӻ�שʯ��û����
	-- untilTap('��������������Ʊ')
	if not wait(function ()
		if findTap('��������������Ʊ') then return 1 end
	end, .1, 8) then
		slog('�����ж���ʧ��')
		return 0
	end
	return 1
end

path.�йܴ��� = function (isActivity)
	log('�йܴ���')
	local greenPos
	local isAgent
	-- ���λ�ÿ��ܲ�һ��
	local trg = isActivity or {563,528,685,584}
	if not wait(function ()
		greenPos = findOne('�����Ƿ���Զ��һ�', {rg = trg, sim = .85})
		if greenPos then return 1 end
	end, .1, 1) then
		log('δ�ҵ��й�')
		slog('δ�ҵ��й�')
	else
		isAgent = 1
		wait(function ()
			if findOne('�����ظ�ս����ɫ', {rg = trg, sim = .9}) then 
				return 1 
			end
			stap(greenPos)
		end)
	end
	return isAgent
end

-- ��ͼģʽ2
path.ͨ��ˢͼģʽ2 = function ()
	print('todo')
end

-- ��ͼ
path.�ַ� = function ()
	local type = '����'..getUIRealValue('�ַ��ؿ�����', '�ַ�����')
	local level = getUIRealValue('�ַ�����', '�ַ�����')
	local fc = current_task.�ַ�����
	return path.ս����ͼ1(type, level, fc)
end

path.�����̳ = function ()
	local type = '����'..getUIRealValue('�����̳�ؿ�����', '�����̳����')..'����'
	local level = getUIRealValue('�����̳����', '�����̳����')
	local fc = current_task.�����̳����
	return path.ս����ͼ1(type, level, fc)
end

path.������Ԩ = function ()
	wait(function ()
		stap(point.ս��)
				ssleep(1)
			if not findOne('������ҳRank') then return 1 end
	end)
	path.ս��ѡ��ҳ()
	wait(function ()
		stap(point.ս��ģʽλ��['��Ԩ'])
		if findOne('����ս������', {keyword = cutStringGetBinWord('��Ԩ')}) then return 1 end
	end)
	if findTap('������Ԩ����') then
		untilTap('������Ԩ����ȷ��')
	end
end

path.���ﱳ������ = function ()
	wait(function ()
		stap({1160,668})
		if findOne('���������Զ�����') then
			return 1
		end
	end)
	
	wait(function ()
		stap('���������Զ�����')
		ssleep(1)
		if findOne('���������Զ����Ŀ��') then return 1 end
	end)
	
	path.���˱���ѡ��(ui_option.���Ｖ��, '��������')
	-- ��������
	wait(function ()
		if findOne('�����������ص����ͳ���') then return 1 end
		stap('�����������ص����ͳ���')
	end)
	
	wait(function ()
		stap({995,657})
		if not findOne('���������Զ����Ŀ��') then
			return 1
		end
	end)
	
	-- ����û������
	if not wait(function ()
		if findTap('�����ͷų���') then
			return 1
		end
	end, .5, 5) then
		return
	end
	wait(function ()
		if findTap('�����ʼ���ȡȷ������') then
			return 1
		end
	end, .5, 5)
end

path.����װ������ = function ()
	wait(function ()
		stap({341,88})
		return findOne('����������ҳ')
	end)
	wait(function ()
		if findOne('��������ȫ��') then
			return 1
		end
		stap({186,164})
	end, 1)
	wait(function ()
		if findOne('��������װ���Զ�ѡ��') then
			return 1
		end
		stap({1081,157})
	end)
	wait(function ()
		if not findOne('��������װ���Զ�ѡ��') then
			return 1
		end
		stap('��������װ���Զ�ѡ��')
	end)
	path.���˱���ѡ��(ui_option.װ������, '����')
	path.���˱���ѡ��(ui_option.װ���ȼ�, '����')
	path.���˱���ѡ��(ui_option.װ��ǿ���ȼ�, '����')
	
	local weaponType = {
	'185|231|00CB64',
	'185|284|00CB64',
	'185|336|00CB64',
	'185|389|00CB64',
	'185|444|00CB64',
	'186|496|00CB64',
	}
	
	for i,v in pairs(weaponType) do
		local pos = string.split(v, '|')
		pos = {tonumber(pos[1]), tonumber(pos[2])}
		wait(function ()
			if findOne(v) then return 1 end
			stap(pos)
		end)
	end
	
	wait(function ()
		if findOne('��������װ���Զ�ѡ��') then
			return 1
		end
		stap({334,90})
	end)
	
	-- ����û������
	if not wait(function ()
		if findTap('����װ������') then
			return 1
		end
	end, .5, 5) then
		return
	end
	wait(function ()
		if findTap('��������ȷ��') then
			return 1
		end
	end, .5, 5)
end

path.����Ӣ�۱��� = function (count, filterFunc)
	count = count or 1

	wait(function ()
		stap({1019,666})
		if findOne('��������Ӣ��') then return 1 end
	end)
	
	wait(function ()
		stap({1081,89})
		ssleep(1)
		if findOne('715|210|44C8FD,715|260|45CBFE,715|312|44C8FD') then
			return 1
		end
	end)
	-- ���˵ȼ�
	if not filterFunc then
		path.���˱���ѡ��(ui_option.Ӣ�۵ȼ�, '����Ӣ��')
	else
		filterFunc()
	end
	
	-- ��������
	local specialSetting = {
		'883|605|00CB64', -- �����ղ�Ӣ��
		'883|657|00CB64', -- �������ܶ�10
		'587|657|00CB64', -- ����MAX�ȼ�
	}
	for i,v in pairs(specialSetting) do
		local pos = string.split(v, '|')
		pos = {tonumber(pos[1]), tonumber(pos[2])}
		wait(function ()
			if findOne(v) then return 1 end
			stap(pos)
		end)
	end
	
	for i=1,count do
		wait(function ()
			stap({548,34})
			if findOne('��������Ӣ��') then return 1 end
		end)
		
		if wait(function ()
			if longDisappearMomentTap("1052|242|7E411F", nil, nil, 2) then
				-- δ��������
				wait(function ()
					if findTap('��������Ӣ��') then
						return 1
					end
				end, .3, 5)
				wait(function ()
					if findTap('����Ӣ�۴���ȷ��') then
						return 1
					end
				end, .3, 5)			
				return 0
			end
			if findOne('714|543|41C2FC') then
				return 1
			end
			stap({1121,273})
		end) == 0 then
			log('��Ӣ�۴���')
			slog('��Ӣ�۴���')
			return 
		end
		
		wait(function ()
			stap({548,34})
			if findOne('��������Ӣ��') then return 1 end
		end)
		
		-- ����û������
		if not wait(function ()
			if findTap('��������Ӣ��') then
				return 1
			end
		end, .3, 5) then
			return
		end
		wait(function ()
			if findTap('����Ӣ�۴���ȷ��') then
				return 1
			end
		end, .3, 5)
	end
end

path.������������ = function ()
	untilAppear('����������ҳ')
	wait(function ()
		if findOne('��������ȫ��') then
			return 1
		end
		stap({186,164})
	end, 1)
	wait(function ()
		if findOne('��������װ���Զ�ѡ��') then
			return 1
		end
		stap({1081,157})
	end)
	wait(function ()
		if not findOne('��������װ���Զ�ѡ��') then
			return 1
		end
		stap('��������װ���Զ�ѡ��')
	end)
	path.���˱���ѡ��(ui_option.�����Ǽ�, '��������')
	path.���˱���ѡ��(ui_option.����ǿ��, '��������ǿ��')
	wait(function ()
		if findOne('��������װ���Զ�ѡ��') then
			return 1
		end
		stap({332,86})
	end)
	-- ����û������
	if not wait(function ()
		if findTap('������������') then
			return 1
		end
	end, .5, 5) then
		return
	end
	wait(function ()
		if findTap('��������ȷ��') then
			return 1
		end
	end, .5, 5)
end
-- ���˵ȼ���������
-- level������table
-- target: Ŀ��ǰ׺
path.���˱���ѡ�� = function (level, target)
	for i,v in pairs(level) do
		local target = target..v
		if current_task[v] then
			wait(function ()
				if findOne(target) then return 1 end
				stap(target)
			end)
		else
			wait(function ()
				if not findOne(target) then
					return 1
				end
				stap(target)
			end)
		end
	end
end

-- target: ��Ҫѡ���
path.���˱����Զ���ѡ�� = function (level, targetName, target)
	if type(target) ~= 'table' then target = {target} end
	for i,v in pairs(level) do
		local targetPos = targetName..v
		if targetPos:includes(target) then
			wait(function ()
				if findOne(targetPos) then return 1 end
				stap(targetPos)
			end)
		else
			wait(function ()
				if not findOne(targetPos) then
					return 1
				end
				stap(targetPos)
			end)
		end
	end
end

path.��ת = function (target, config)
	wait(function ()
		if not longAppearMomentDisAppear(target, config, nil, 1) then return 1 end
		back()
	end, 2, 5 * 60)
end

-- backFunc: ���غ���
path.�������� = function (backFunc)
	-- ʶ�𱳰�����
	slog('�������ռ�')
	log('�������ռ�!')
	local bagSpaceType
	local bagKey = {'Ӣ��', 'װ��', '����'}
	wait(function ()
		bagSpaceType = findOne('����������', {keyword = bagKey})
		if bagSpaceType then
			bagSpaceType = bagSpaceType[1].text
			return 1
		end
	end)
	-- ���뱳��
	untilTap('���������ռ䲻��')
	-- ������
	-- print(bagSpaceType)
	if bagSpaceType:includes({'Ӣ��'}) then
		path.����Ӣ�۱���()
	elseif bagSpaceType:includes({'װ��'}) then
		path.����װ������()
	elseif bagSpaceType:includes({'����'}) then
		path.������������()
	end
	backFunc()
end

path.��3�ǹ��� = function ()
	path.��Ϸ��ҳ()
	-- �� + ���� ?
	setNumberConfig("is_refresh_book_tag", 2)
	local upgradeCount = current_task.��3�ǹ�������
	local type = current_task.��3�ǹ�������
	if type == 0 or type == 2 then
		path.������_3(upgradeCount)
	end
	if type == 1 or type == 2 then
		path.��Ϸ��ҳ()
		if not path.���Ҳ���('�Ҳ���Ӣ��') then
			return
		end
		-- ֱ��������3�ǵ�
		path.����Ӣ�۱���(1352955539, function ()
			path.���˱����Զ���ѡ��(ui_option.Ӣ�۵ȼ�, '����Ӣ��', {3})
		end)
	end
end

path.������_3 = function (upgradeCount)
	if not path.���Ҳ���('�Ҳ���Ӣ��') then
		return
	end
	wait(function ()
		if findOne('714|209|45CBFE,716|261|44C8FD,715|312|44C8FD') then
			return 1
		end
		stap({1085,89})
	end)
	-- ���˵ȼ�
	path.���˱����Զ���ѡ��(ui_option.Ӣ�۵ȼ�, '����Ӣ��', {2})
	
	-- ��������
	local specialSetting = {
		'883|605|00CB64', -- �����ղ�Ӣ��
		'883|657|00CB64', -- �������ܶ�10
		-- '587|657|00CB64', -- ����MAX�ȼ�
		'590|604|201F1A' -- �ر���С����
	}

	for i,v in pairs(specialSetting) do
		local pos = string.split(v, '|')
		pos = {tonumber(pos[1]), tonumber(pos[2])}
		wait(function ()
			if findOne(v) then return 1 end
			stap(pos)
		end)
	end

	wait(function ()
		if findOne('����Ӣ�۾���') then
			return 1
		end
		stap({485,31})
	end)

	-- ���и���Դ����
	local target = {'����Ӣ��������첻��', '���������̵깺����Դ����', '����Ӣ��������������', 
								  '����Ӣ������2', '����Ӣ������3', '����Ӣ������3��'}
	local tkey = {'��Դ����', '����'}
	local curIdx = sgetNumberConfig('upgrade_3x_hero', 0)
	for i=1,upgradeCount do
		if i > curIdx then
			if not wait(function ()
				if not findOne('����Ӣ������3��') then
					return 1
				end
				stap({1063,243})
			end, .1, 5) then
				log('��2��Ӣ��')
				slog('��2��Ӣ��')
				return
			end
			untilTap('����Ӣ������1')
			local t, v
			if wait(function ()
				t, v = findOne(target, {rg = {16,73,385,174}, keyword = tkey})
				if v == '����Ӣ������3��' then
					log('����2�Ǹ���: '..i..'/'..upgradeCount)
					return 1
				end
				if  v == '����Ӣ��������첻��' or 
						v == '���������̵깺����Դ����' or 
						v == '����Ӣ��������������' then
						-- log(v)
						log('��Դ����')
						slog('��Դ����')
						return 0
				end
				stap({997,664})
				stap(t)
			end) == 0 then
				return
			end
			setNumberConfig("upgrade_3x_hero", i)
		end
	end
end

path.���Ҳ��� = function (pos)
	if not findOne('������ҳRank') then
		log('δ����ҳ')
		return 
	end
	wait(function ()
		if findOne('�����Ҳ�����') then
			return 1
		end
		stap({1241,32})
	end)
	wait(function ()
		if not findOne('�����Ҳ�����') then
			return 1
		end
		stap(point[pos])
	end)
	return 1
end

path.������� = function ()
	path.��Ϸ��ҳ()
	wait(function ()
		stap({247,214})
		return findOne('327|239|5B80C4,316|240|BF898F,335|238|4CEAFF')
	end)
	-- ��ʼ����
	-- ������ʾ���
	local noTipTap = false
	wait(function ()
		if findOne('612|638|F4A300,680|637|FBA900') then
			log('��Ҷ������')
			slog('��Ҷ������')
			return 1
		end
		if not noTipTap and findTap('814|549|0E4810,833|551|0F4C12,816|562|1CCF5E,830|561|149F35') then
			noTipTap = true
		end
		stap({903,280})
	end, .5, nil, true)
end

path.��Ϸ���� = function ()
	wait(function ()
		stap(point.�)
		ssleep(1)
		return not findOne('������ҳRank')
	end)
	wait(function ()
		
	end)
	-- ������� + ����
	-- ǩ��
end

path.��� = function ()
	wait(function ()
		stap(point.֧�߹���)
		ssleep(1)
		return not findOne('������ҳRank')
	end)

	wait(function ()
		stap({1243,415})
		stap({350,28})
		return findTap('���ð��')
	end)

	wait(function () return findTapOnce('���׼��ս��') end)

	-- longAppearAndTap('������ѡ�����', nil, nil, 2)
	wait(function ()
		findTapOnce('������ѡ�����')
		return wait(function ()
			if not findOne('������ѡ�����') then return 1 end
		end, .5, 5)
	end)

	local fightCount = current_task.��Ǵ���
	return path.ͨ��ˢͼģʽ1(fightCount, nil, '���')
end

path.� = function ()
	local fc = current_task.�����
	wait(function ()
		stap(point.֧�߹���)
		ssleep(1)
		return not findOne('������ҳRank')
	end)
	local e, w
	wait(function ()
		stap({61,187})
		stap({1059,285})
		e, w = findOne({'���ҳ', '�ð��'}, {keyword = '��Ļ'})
		return w
	end)
	-- �ж�����һ�ֻ
	if w == '�ð��' then
		log('�-Ĭ�Ϲؿ�')
		wait(function ()
			stap({1166,661})
			return findOne('���׼��ս��')
		end)
		wait(function ()
			findTapOnce('���׼��ս��')
			return wait(function ()
			if not findOne('���׼��ս��') then return 1 end
			end, .5, 5)
		end)
		wait(function ()
				findTapOnce('������ѡ�����')
				return wait(function ()
				if not findOne('������ѡ�����') then return 1 end
			end, 1, 4)
		end)
		return path.ͨ��ˢͼģʽ1(fc, nil, '���')
	elseif w == '���ҳ' then
		log('�-��ѡ�ؿ�')
		wait(function ()
			stap({994,657})
			return findOne('�������½�', {keyword = 'ս����ʼ'})
		end)
		local level = getUIRealValue('�����', '�����')
		return path.ս����ͼ1(nil, level, fc, {175,613,357,714})
	end
end