package aynu.test.etms.VoiceLogin;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.lang.String;

public class ClientDemo{
    public static void main(String[] args) {
        VoicePrintApi obj = new VoicePrintApi("203772939", "8yek29ntj6j76q8ukm69nvaqnbtfxlp2");
        System.out.println("没有空指针");
        try {         
            if (obj.getAccess()) {
//                String res = obj.getAlgoList();     //获取算法列表
//                System.out.println("1");
//                JsonParser jp  = new JsonParser();
//                JsonObject jo = jp.parse(res).getAsJsonObject();
//                System.out.println("2");
//                String algoId = jo.get("body").getAsJsonObject().get("data\\\").getAsJsonObject().get("algo_id").getAsString();
//                System.out.println("3");
             //  String res2 = obj.uploadFile("login", "audios/blob887.wav", 3000);//上传文件
               // System.out.println(res2);
               // String res3 = obj.createVpstore("ivector-1-iv_tx_8k-1");//创建声纹库
               // String vpstoreId = jo.get("")
              //  System.out.println(res3);
               // String res = obj.getVpstoreList(0, 0);//获取声纹库列表

                String[] fileIds = {"1577198254973_ZcuoElZjOJ_login"};
                String res4 = obj.registerVoicePrint("104c0276-13c8-4492-8c9e-2153595bc37a", "123", fileIds, true);
                System.out.println(res4);
                //String res = obj.getVoicePrintList("xxxxxxxxxxxxxxxxx", 0, 0);

                //String[] vpIds = {"aaaaaa", "bbbbbbb"};
               //String res = obj.compareVoicePrint("xxxxx", "xxxxxx", vpIds);

            }
        } catch (Exception e) {
            System.out.println(e);
        }        
    }
}
