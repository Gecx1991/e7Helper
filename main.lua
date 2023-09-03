-- ϵͳʱ��
time = systemTime
update_source = 'https://gitee.com/boluokk/e7-helper/raw/master/release/'
update_source_fallback = update_source
-- apk level ����
is_apk_old = function() return getApkVerInt() < 0 end
apk_old_warning = "��ô��������" .. getApkVerInt()
release_date = "09.03 13:08"
release_content = '\n(1)����ʱ�쳣�޸�\n(2)��3���쳣�޸�'
-- ��ȡworkPath
root_path = getWorkPath() .. '/'
-- ��ֹ�ȸ���
hotupdate_disabled = true
-- log ��־��ʾ�����½�
-- true stoat ��ӡ
-- false print ��ӡ
logger_display_left_bottom = true
-- ��ӡ��ǰִ�е�������(�����ĳ��ͼɫ��)
detail_log_message = not logger_display_left_bottom
-- ���ò���
disable_test = true
-- ��ͼ�ӳ�
capture_interval = 0
-- ��Ϸ����ʶͼ���
game_running_capture_interval = 3
-- ���������ļ�����
fileNames = {'config.txt', 'fightConfig.txt', 'bagConfig.txt'}
-- ����ӳ�
tap_interval = 0
-- app����ʱ��
app_is_run = time()
--server pkg name
server_pkg_name = {
  ["����"] = 'com.zlongame.cn.epicseven',
  ['B��'] = 'com.zlongame.cn.epicseven.bilibili',
  ['���ʷ�'] = 'com.stove.epic7.google',
}
-- ��ǰ������
current_server = "����"
-- wait ���
wait_interval = .7
-- �Ƿ��쳣�˳�
is_exception_quit = false
-- UI�������
ui_config_finish = false
-- loggerID
logger_ID = nil
-- ��ȡ״̬��
sgetNumberConfig = function (key, defval) return tonumber(getNumberConfig(key, defval)) end
-- �Ƿ���ˢ��ǩ
is_refresh_book_tag = sgetNumberConfig('is_refresh_book_tag', 0)
-- ��ǰ����
current_task_index = sgetNumberConfig("current_task_index", 0)
-- �쳣�˳�����
exception_count = sgetNumberConfig('exception_count', 1)
-- ��ǰ�˺�����
current_task = {}
-- �����Ϸ״̬ 10s
check_game_status_interval = 10000
-- ���ͼɫʶ��ʱ��
getMillisecond = function (secound) return secound * 1000 end
-- ��λ��
check_game_identify_timeout = getMillisecond(20)
-- ����ssleep���
other_ssleep_interval = 1
-- ��������Ϣʱ��
single_task_rest_time = 5
-- ��Դ˵���ֲ��ַ
open_resource_doc = 'https://boluokk.gitee.io/e7-helper'
-- ȫ�ֹؿ�����(���������ʱ����ʾ: ������ 1/100)
global_stage_count = 0
-- ��ӡ������Ϣ
print_config_info = false
require("point")
require('path')
require("util")
require("userinterface")
require("test")
-- �ֱ�����ʾ
-- DPI 320
-- �ֱ��� 720x1280
-- ����   1280x720
local disPlayDPI = 320
displaySizeWidth, displaySizeHeight = getDisplaySize()
-- if disPlayDPI ~= 320 or ((displaySizeHeight ~= 1280 and displaySizeHeight > 0) and 
--                          (displaySizeHeight ~= 720 and displaySizeHeight > 0)) 
--                      or ((displaySizeWidth ~= 720 and displaySizeWidth > 0) and 
--                          (displaySizeWidth ~= 1280 and displaySizeWidth > 0)) then
--   wait(function ()
--     toast("��ǰ�ֱ��ʣ�"..displaySizeWidth.."x"..displaySizeHeight.."\tDPI��"..disPlayDPI.."\n"..
--           "���ֶ����ó�(ģ�������������������)��\n�ֱ���: 720x1280����1280x720 \nDPI��320\n֮�������ű�")
--   end, 1, 1)
-- end

-- �쳣����
setEventCallBack()

local scriptStatus = sgetNumberConfig("scriptStatus", 0)
-- �ȸ��¿�ʼ
if scriptStatus == 0 then
  consoleInit()
  initLocalState()
  slog('���¸���ʱ��: '..release_date)
  slog('��������: '..(release_content or '����'))
  if not hotupdate_disabled then hotUpdate() end
  sui.show()
else
  setNumberConfig("scriptStatus", 0)
  -- ����쳣�رսű�
  -- �˳���Ϸ����������Ϸ?
  if exception_count > 3 then 
    slog('����3���쳣�˳�') 
    setNumberConfig("exception_count", 1) 
    exit() 
  else
    setNumberConfig("exception_count", exception_count + 1)
  end 
  -- ���ر�������
  -- current_task = read('config.txt', true)
  current_task = uiConfigUnion(fileNames)
  if is_refresh_book_tag == 1 then
    path.ˢ��ǩ(sgetNumberConfig("refresh_book_tag_count", 0))
  elseif is_refresh_book_tag == 2 then
    path.��3�ǹ���()
  else
    path.��Ϸ��ʼ()
  end
end