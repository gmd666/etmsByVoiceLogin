package aynu.test.etms.controller;

import com.alibaba.fastjson.JSON;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Controller
public class GetAudios {
    /**
     *1.页面获取信息保存到本地；
     */
    @RequestMapping("/getAudio.do")
    public String getAudio(MultipartFile audio) {
        System.out.println("请求到了");
        System.out.println(audio);
        Map<String, String> modelMap = new HashMap<>();
        if (!audio.isEmpty()&&audio.getSize()>0) {
            String storePath = "C://Users//MaiBenBen//Desktop//java项目//etms-master//etms-master//audios";
            Random r = new Random();
            String fileName = audio.getOriginalFilename();
            String[] split = fileName.split(".wav");
            fileName = split[0] + r.nextInt(1000);
            fileName = fileName + ".wav";
            File filePath = new File(storePath, fileName);
            if (!filePath.getParentFile().exists()) {
                filePath.getParentFile().mkdirs();// 如果目录不存在，则创建目录
            }
            try {
                audio.transferTo(new File(storePath + File.separator + fileName));// 把文件写入目标文件地址
            } catch (Exception e) {
                e.printStackTrace();
                modelMap.put("back", "error");
                String json = JSON.toJSONString(modelMap);
                return json;
            }
            modelMap.put("back", "success");

        } else {
            modelMap.put("back", "error");
        }
        String json = JSON.toJSONString(modelMap);
        return json;
    }
}
