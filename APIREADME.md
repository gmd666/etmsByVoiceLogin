``# 一、 概述

- 本示例为java代码,该sdk将所有http请求封装到"VoicePrintApi"类中, 每一个http请求对应该类中的一个方法
- 所有接口除了 getAccess (获取访问权限)返回bool类型以外, 其他接口均返回http响应的json字符串),你可以根据你的需求从响应体中提取想要的信息
- 具体请求字段和返回字段请查看 [API接口文档](API接口文档.md)
- 请参考src/test/java/com/aliyun/api/gateway/demo目录下 [ClientDemo.java](src/test/java/com/aliyun/api/gateway/demo/ClientDemo.java), 该文件演示了如何调用api

# 二、 接口列表
Method | HTTP request | Description
------------- | ------------- | -------------
[**getAccess**]| **GET** /aliyun/vpr/api/v1/user/login | 获取访问权限
[**getAlgoList**]| **GET** /aliyun/vpr/api/v1/users/{user_id}/algorithms | 列出算法列表
[**createVpstore**]| **POST** /aliyun/vpr/api/v1/users/{user_id}/vpstore | 创建声纹库
[**getVpstoreList**]| **GET** /aliyun/vpr/api/v1/users/{user_id}/vpstores | 获取声纹库列表
[**uploadFile**]| **POST** /aliyun/vpr/api/v1/users/{user_id}/bucket/{bucket_name}/file/{file_name}/ttl/{ttl}/upload | 上传文件
[**registerVoicePrint**]| **POST** /aliyun/vpr/api/v1/users/{user_id}/vpstore/{vpstore_id}/voiceprint/register | 注册声纹
[**getVoicePrintList**]| **GET** /aliyun/vpr/api/v1/users/{user_id}/vpstore/{vpstore_id}/voiceprints | 获取声纹列表
[**compareVoicePrint**]| **POST** /aliyun/vpr/api/v1/users/{user_id}/vpstore/{vpstore_id}/voiceprint/compare | 声纹比对

# 三、 如何调用接口
```
# 使用你的appKey和appSecret去创建一个api实例，后面所有操作通过调用api实例的方法
# 创建实例后必须先调用getAccess方法获取访问权限
# timeout 为请求超时(单位ms)，如果不带该参数则默认为1000ms
VoicePrintApi obj = new VoicePrintApi("your appKey", "your appSecret", timeout);
try {         
    if (obj.getAccess()) {
        String res1 = obj.getAlgoList();                                // 获取算法列表
        String res2 = obj.uploadFile("bucket", "filepath", ttl);        // 上传wav文件

        System.out.println(res1);
        System.out.println(res2);
    }
} catch (Exception e) {
    System.out.println(e); 
}        
```

# 四、 接口详细介绍
## 1、获取访问权限 * boolean getAccess()
### *描述*
    必须调用该方法返回True后才能调用其他方法，否则会失败
### *参数*
    无
### *返回*
    bool值, true 为获取权限成功，则可以继续调用该实例其他方法（接口），false 为失败

## 2、 获取算法列表 * String getAlgoList()
### *描述*
    获取算法列表可用的算法列表，后续需要使用算法id去创建声纹库（即绑定算法）
### *参数*
    无
### *返回*
    http响应的json字符串

## 3、 创建声纹库 * String createVpstore(String algoId)
### *描述*
    创建声纹库，即绑定算法，后面注册声纹需要在某个声纹库下注册，在该声纹库下注册的声纹则是使用算法id为 algo_id 的算法
   【注】： 可以使用同一个算法id创建多个声纹库
### *参数*
参数名称 | 参数类型|必须 | 来源 | 描述
-------|-------|--------|---------------- |-----
algoId | String | 是  | 通过获取算法列表获得 | 算法id
### *返回*
    http响应的json字符串

## 4、 获取声纹库列表 * String getVpstoreList(int offset, int limit)
### *描述*
    获取已创建的声纹库列表 
### *参数*
参数名称 | 参数类型|必须 | 描述
-------|-------|--------|---------------- 
offset | int | 是  | 查询起始偏移量 【最小从0开始】
limit  | int | 是  | 查询记录个数限制 【如为0则查询所有记录，但一次最多查询999条记录,如果查询结果超过999条,则只返回前999条，如需查询所有记录，请使用分页查询】
### *返回*
    http响应的json字符串

## 5、 上传wav文件(支持0~5M wav音频文件) * String uploadFile(String bucket, String filePath, int ttl)
### *描述*
    将wav文件上传到储存空间，并返回一个key(file_id)来标识该文件, 后面注册声纹，
    声纹比对都会用到该key
   【注： 1、只支持wav格式的音频文件  2、 同一个文件每次上传都会返回不同的key】
### *参数*
参数名称 | 参数类型|必须 | 来源 | 描述 | 限制条件
-------|-------|--------|----------- |----- |-------
bucket      | String | 是  | 用户自定义       | 储存空间名     | 最大长度30
filePath   | String | 是  | 用户wav文件路径   | wav文件路径   | 文件名最大长度30，例: filePath = /home/xxx/file.wav, 则"file.wav"字符长度不能超过30
ttl         | int | 是  | 用户自定义       | 文件存储时间（单位：秒）  | 取值范围 0～9223372036854775807, 低于30s按30s算

### *返回*
    http响应的json字符串

## 6、 注册声纹 * String registerVoicePrint(String vpstoreId, String registerId, String[] fileIds, boolean force)
### *描述*
    在已创建的某个声纹库下, 使用上传文件返回的file_id(文件id)列表(将多个文件返回的file_id组成列表)注册声纹
   【注：1、可以使用多个上传的文件key来注册一条声纹 2、如果上传的文件已经失效，注册将失败】
### *参数*
参数名称 | 参数类型|必须 | 来源 | 描述 | 限制条件
-------|-------|--------|----------- |----- |-------
vpstoreId      | String | 是  | 通过创建声纹库或获取声纹库获取       | 声纹库id     | 
registerId      | String | 是  | 用户自定义       | 声纹注册id     | 最大长度30
fileIds      | String数组 | 是  | 通过上传文件返回的file_id组成的数组       | 文件id数组     |
force      | bool | 是  | 用户自定义       | 是否覆盖已有声纹，force为true则覆盖，否则不覆盖， |
### *返回*
    http响应的json字符串

## 7、 获取声纹列表 * String getVoicePrintList(String vpstoreId, int offset, int limit)
### *描述*
    获取已注册的声纹列表
### *参数*
参数名称 | 参数类型|必须 | 来源 | 描述 |
-------|-------|--------|----------- |----- 
vpstoreId      | String | 是  | 通过创建声纹库或获取声纹库获取       | 声纹库id     |
offset          | int | 是  | 用户自定义 |   查询起始偏移量 【最小从0开始】
limit           | int | 是  | 用户自定义 |   查询记录个数限制 【如为0则查询所有记录，但一次最多查询999条记录,如果查询结果超过999条,则只返回前999条，如需查询所有记录，请使用分页查询】 
### *返回*
    http响应的json字符串

## 8、 声纹比对 * String compareVoicePrint(String vpstoreId, String fileId, String[] voicePrintIds)
### *描述*
    声纹比对,返回每条声纹比对的比分
   【注：一次最多对10条声纹】
### *参数*
参数名称 | 参数类型|必须 | 来源 | 描述 
-------|-------|--------|----------- |----- 
vpstoreId      | String | 是  | 通过创建声纹库或获取声纹库获取       | 声纹库id     |
fileId      | String | 是  | 通过上传文件返回的file_id       | 文件id     |
voicePrintIds      | String数组 | 是  | 已注册的声纹的声纹id(即注册声纹接口中的注册id)组成的数组       | 声纹id数组     |
### *返回*
    http响应的json字符串
