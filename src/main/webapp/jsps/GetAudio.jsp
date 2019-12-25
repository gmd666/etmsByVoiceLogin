<%--
  Created by IntelliJ IDEA.
  User: mengdiguo
  Date: 2019/12/24 0024
  Time: 下午 3:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title id="title"></title>

</head>
<body>
<audio id="player" autoplay controls></audio>
<p>
    <button onclick="start_reco()">开始录音</button>
</p>
<p>
    <button onclick="ai_reco()" style="background-color: cornflowerblue">发送语音指令</button>
</p>
</body>
<script type="application/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/Recorder.js"></script>
<script type="application/javascript">
    var reco = null;
    var audio_context = new AudioContext();//音频内容对象
    navigator.getUserMedia = (navigator.getUserMedia ||
        navigator.webkitGetUserMedia ||
        navigator.mozGetUserMedia ||
        navigator.msGetUserMedia); // 兼容其他浏览器

    navigator.getUserMedia({audio: true}, create_stream, function (err) {
        console.log(err)
    });

    function create_stream(user_media) {
        var stream_input = audio_context.createMediaStreamSource(user_media);
        reco = new Recorder(stream_input);
    }


    function start_reco() {
        reco.record();
    }

    function ai_reco() {
        reco.stop();

        reco.exportWAV(function (wav_file) {
            console.log(wav_file);
            var formdata = new FormData(); // form 表单 {key:value}
            formdata.append("audio", wav_file); // form input type="file"

            $.ajax({
                url: "/getAudio.do",
                type: 'post',
                processData: false,
                contentType: false,
                data: formdata,
                dataType: 'json',
                success: function (data) {
                    console.log(data);
                    document.getElementById("player").src = "/get_audio/" + data.filename;
                }
            })
        });
        reco.clear();
    }

</script>
</html>
