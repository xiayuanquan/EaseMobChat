# EaseMobChat
环信集成
--------

提示：
-----

###  这个demo下载下来后编译时有一个错误，解决掉这个问题就可以正常使用了，解决看下面：!!!
  
  ![image](https://github.com/xiayuanquan/EaseMobChat/blob/master/EaseMobChat/screenshots/lib.png)
  
  这个问题是由于github直接会拒绝上传大于100M的文件，所以我在上传时项目时直接忽略掉了lib/libEasemobClientSDK.a静态包，用户需要自己去下载这个静态包，然后将工程中的原lib删除干净后，把这个新的下载的lib/libEasemobClientSDK.a拖到工程相应的位置即可，编译一下马上build success成功。
  
  libEasemobClientSDK.a 下载路径：http://docs.easemob.com/start/300iosclientintegration/20iossdkimport
  
  
效果图：
------
  
  ![image](https://github.com/xiayuanquan/EaseMobChat/blob/master/EaseMobChat/screenshots/chat1.png)
  ![image](https://github.com/xiayuanquan/EaseMobChat/blob/master/EaseMobChat/screenshots/chat2.png)
  
       
