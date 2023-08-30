sui = {}
-- ui�¼�
suie = {}
parentUid = 'E7Helper'
grindUid = 'ˢͼ����'
bagUid = '������������'
-- bin: bid��bname
addButton = function (bin, partid)
  partid = partid or parentUid
  ui.addButton(partid, bin, bin)
  ui.setOnClick(bin, 'suie.'..bin..'()')
end
setButton = function (bin, w, h)
  w = w or 100
  h = h or 100
  -- ����¼�����
  ui.setButton(bin, bin, w, h)
end
newLayout = function (pid)
  pid = pid or parentUid
  ui.newLayout(pid, 720, -2)
end
newRow = function (pid)
  pid = pid or parentUid
  ui.newRow(pid, uuid())
end
addTab = function (pin, pid)
  pid = pid or parentUid
  ui.addTab(pid, pin, pin)
end
addTabView = function (cid)
  ui.addTabView(parentUid,cid)
end
addTextView = function (text, pid)
  pid = pid or parentUid
  ui.addTextView(pid,text,text)
end
addRadioGroup = function (id, data, pid)
  pid = pid or parentUid
  if type(data) ~= 'table' then data = {data} end
  ui.addRadioGroup(pid,id,data,0,-1,70,true)
end
addCheckBox = function (id, selection, pid, defaluValue)
  pid = pid or parentUid
  ui.addCheckBox(pid,id,selection, defaluValue)
end
addEditText = function (id, text, pid)
  pid = pid or parentUid
  ui.addEditText(pid,id,text)
end
saveProfile = function (path)
  ui.saveProfile(root_path..path)  
end
loadProfile = function (path)
  ui.loadProfile(root_path..path)
end
addSpinner = function (id, data, pid)
  pid = pid or parentUid
  data = data or {}
  ui.addSpinner(pid, id ,data)
end
setDisabled = function (id)
  ui.setEnable(id,false)
end
setEnable = function ()
  ui.setEnable(id,true)
end
dismiss = function (id) ui.dismiss(id) end
suie.�˳� = exit
suie.���� = function ()
  -- �Ƿ�������������(��������, ��Ȼ������⿨��)
  if not sFileExist('bagConfig.txt') then saveProfile('config.txt') log('����������������!') suie.������() return end
  suie.����ǰ()
  if print_config_info then
    print(current_task)
    exit()
  end
  path.��Ϸ��ʼ()
end
suie.����ǰ = function ()
  -- ��������
  saveProfile('config.txt')
  -- ��ȡ�����ļ�����
  current_task = uiConfigUnion(fileNames)
  ui_config_finish = true
  dismiss(parentUid)
end
suie.��ʼˢ��ǩ = function ()
  suie.����ǰ()
  path.ˢ��ǩ(sgetNumberConfig("refresh_book_tag_count", 0))
end
suie.ʹ��˵�� = function ()
  runIntent({
    ['action'] = 'android.intent.action.VIEW',
    ['uri'] = open_resource_doc
  })
  exit()
end
suie.ˢͼ���� = function ()
  sui.showNotMainUI(sui.showGrindSetting)
end
suie.ˢ��UI = function ()
  for i,v in pairs(fileNames) do sdelfile(v) end
  reScript()
end
suie.ˢͼ����ȡ�� = function ()
  sui.hiddenNotMainUI(grindUid)
end
suie.ˢͼ���ñ��� = function ()
  saveProfile('fightConfig.txt')
  suie.ˢͼ����ȡ��()
end
suie.������ = function ()
  sui.showNotMainUI(sui.showBagSetting)
end
suie.��������ȡ�� = function ()
  sui.hiddenNotMainUI(bagUid)
end
suie.�������ñ��� = function ()
  saveProfile('bagConfig.txt')
  suie.��������ȡ��()
end
suie.��3�ǹ�����ʼ = function ()
  suie.����ǰ()
  path.��3�ǹ���()
end
suie.������� = function ()
  suie.����ǰ()
  path.�������()
end
-- ��ҳ
sui.show = function ()
  newLayout()
  newRow()
  -- ��Դ��Ϣ
  addTextView('��ѿ�Դ��������(���·�ʹ��˵�� or ��Ⱥ)\n'..
              'QQȺ:206490280      '..
              'QQƵ����:24oyp5x92q')
  newRow()
  -- ������
  addTextView('������: ')
  local servers = ui_option.������
  addRadioGroup('������', servers)
  newRow()
  -- �ճ�������
  local selections = ui_option.����
  for i,v in pairs(selections) do
    addCheckBox(v, v)
    if i % 3 == 0 then newRow() end
  end

  -- ��Ҫ���ü�����������
  newRow()
  addTextView('JJC:')
  addCheckBox('Ҷ����Ʊ', 'Ҷ����Ʊ')
  addTextView('ˢ�½�ս����:')
  addEditText('��ս����', '30')
  newRow()
  addTextView('JJCÿ�ܽ���: ')
  addRadioGroup('������ÿ�ܽ���', ui_option.������ÿ�ܽ���)
  newRow()
  addTextView('JJC����: ')
  addRadioGroup('����������', ui_option.����������)
  -- local mission = {'ʥ��', '̽��', '�ַ�', 'ս��'}
  -- addTextView('��ǲ����:')
  -- addRadioGroup('��ǲ����', mission)
  newRow()
  addTextView('���ž�����')
  addRadioGroup('���ž�������', ui_option.���ž�������)
  newRow()
  local tag = ui_option.ˢ��ǩ����
  addTextView('��ǩ: ')
  for i,v in pairs(tag) do 
    if i == 3 then
      addCheckBox(v, v, nil)
    else 
      addCheckBox(v, v, nil, true)
    end
  end
  -- �����޸�����
  newRow()
  addTextView('����:')
  addEditText('���´���', '333')
  addButton('��ʼˢ��ǩ')
  newRow()
  addTextView('��3�ǹ���:')
  addRadioGroup('��3�ǹ�������', ui_option.��2�ǹ�������)
  newRow()
  addEditText('��3�ǹ�������','100')
  addTextView('��')
  addButton('��3�ǹ�����ʼ')
  addTextView('����ǰ��������!')
  newRow()
  addButton('�������')
  newRow()
  addButton('ʹ��˵��')
  addTextView('  |  ')
  addButton('����')
  addButton('�˳�')
  newRow()
  addButton('ˢ��UI')
  addTextView('  |  ')
  addButton('������')
  addButton('ˢͼ����')
  ui.show(parentUid, false)

  -- load config
  loadProfile('config.txt')
  wait(function ()
    if ui_config_finish then return true end
  end, .05, nil, true)
end
-- ս������
sui.showGrindSetting = function ()
  newLayout(grindUid)
  -- addButton('ˢͼ����', grindUid)
  local passAll = ui_option.ս������
  for i,v in pairs(passAll) do
    local cur = i..''
    if cur:includes({1,3,5,6}) then
      addCheckBox(v, v, grindUid)
    else
      addCheckBox(v, v, grindUid)
      -- ��ʱ����
      -- todo
      setDisabled(v)
    end
    if i % 4 == 0 then
      newRow(grindUid)
    end
  end
  newRow(grindUid)
  addTextView('�����ж���:', grindUid)
  addRadioGroup('�����ж�������', ui_option.�����ж�������, grindUid)
  newRow(grindUid)
  addTextView('�ַ�: ', grindUid)
  addSpinner('�ַ�����', ui_option.�ַ��ؿ�����, grindUid)
  addSpinner('�ַ�����', ui_option.�ַ�����, grindUid)
  addTextView('��', grindUid)
  addEditText('�ַ�����', '100', grindUid)
  addTextView('��', grindUid)
  newRow(grindUid)
  addTextView('�Թ���', grindUid)
  newRow(grindUid)
  addTextView('�����̳��', grindUid)
  addSpinner('�����̳����', ui_option.�����̳�ؿ�����, grindUid)
  addSpinner('�����̳����', ui_option.�����̳����, grindUid)
  addTextView('��', grindUid)
  addEditText('�����̳����', '100', grindUid)
  addTextView('��', grindUid)
  newRow(grindUid)
  addTextView('��Ԩ��', grindUid)
  newRow(grindUid)
  newRow(grindUid)
  addTextView('��ǣ�', grindUid)
  addEditText('��Ǵ���', '100', grindUid)
  addTextView('��', grindUid)
  newRow(grindUid)
  addTextView('���', grindUid)
  addSpinner('�����', ui_option.�����, grindUid)
  addTextView('��', grindUid)
  addEditText('�����', '100', grindUid)
  addTextView('��', grindUid)
  newRow(grindUid)
  addButton('ˢͼ���ñ���', grindUid)
  addButton('ˢͼ����ȡ��', grindUid)
  ui.show(grindUid, false)
  loadProfile('fightConfig.txt')
end
sui.showNotMainUI = function (fun)
  dismiss(parentUid)
  fun()
end
sui.hiddenNotMainUI = function (hiddenID)
  dismiss(hiddenID)
  sui.show()
end
-- ��������
sui.showOtherFunc = function ()
end
-- ��������
sui.showBagSetting = function ()
  newLayout(bagUid)
  newRow(bagUid)
  addTextView('���ﱳ��', bagUid)
  newRow(bagUid)
  -- Ĭ��: B C D
  for i,v in pairs(ui_option.���Ｖ��) do
    if v:includes({'B', 'C', 'D'}) then
      addCheckBox(v, v, bagUid, true)
    else
      addCheckBox(v, v, bagUid)
    end
  end
  newRow(bagUid)
  addTextView('װ������', bagUid)
  newRow(bagUid)
  -- Ĭ�ϣ�
  for i,v in pairs(ui_option.װ������) do
    if v:includes({'һ��', '�߼�', 'ϡ��'}) then
      addCheckBox(v, v, bagUid, true)
    else
      addCheckBox(v, v, bagUid)
    end
  end
  newRow(bagUid)
  for i,v in pairs(ui_option.װ���ȼ�) do
    if v:includes({'28', '42', '57', '71', '72'}) then
      addCheckBox(v, v, bagUid, true)
    else
      addCheckBox(v, v, bagUid)
    end
    if i % 4 == 0 then
      newRow(bagUid)
    end
  end
  newRow(bagUid)
  for i,v in pairs(ui_option.װ��ǿ���ȼ�) do
    if v:includes({'+0', '9'}) then
      addCheckBox(v, v, bagUid, true)
    else
      addCheckBox(v, v, bagUid)
    end
    if i % 4 == 0 then
      newRow(bagUid)
    end
  end
  newRow(bagUid)
  addTextView('��������', bagUid)
  newRow(bagUid)
  for i,v in pairs(ui_option.�����Ǽ�) do 
    if v:includes({'1', '2', '3'}) then
      addCheckBox(v, v, bagUid, true)
    else
      addCheckBox(v, v, bagUid)
    end
    if i % 7 == 0 then
      newRow(bagUid)
    end
  end
  newRow(bagUid)
  for i,v in pairs(ui_option.����ǿ��) do
    if v:includes({'+0', '10'}) then
      addCheckBox(v, v, bagUid, true)
    else
      addCheckBox(v, v, bagUid)
    end
    if i % 4 == 0 then
      newRow(bagUid)
    end
  end
  newRow(bagUid)
  addTextView('Ӣ�۵ȼ�', bagUid)
  newRow(bagUid)
  for i,v in pairs(ui_option.Ӣ�۵ȼ�) do 
    if v:includes({'1', '2', '3'}) then
      addCheckBox(v, v, bagUid, true)
    else
      addCheckBox(v, v, bagUid)
    end
    if i % 7 == 0 then
      newRow(bagUid)
    end
  end
  newRow(bagUid)
  addButton('�������ñ���', bagUid)
  addButton('��������ȡ��', bagUid)
  ui.show(bagUid, false)
  loadProfile('bagConfig.txt')
end