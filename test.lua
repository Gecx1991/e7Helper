
test = function ()
  logger_display_left_bottom = false
  current_task = uiConfigUnion(fileNames)
  local target = {'�������ȡ��','��������ȷ��','���������ռ䲻��', 
                '�����ж�������', '�������½�', '�������½ǻ', 
                '����ս��ʧ��', '����ս���ʺ�'} -- �������롢����������ܻ����
  log(findOne(target))
  exit()
end
if not disable_test then test() end