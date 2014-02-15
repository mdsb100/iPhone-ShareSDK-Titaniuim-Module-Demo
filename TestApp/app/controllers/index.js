testsharesdk=require("com.baidao.testsharesdk")

function doClick(e) {
  testsharesdk.share({
    title: "测试",
    content: "Hello World!!!",
    url: "www.baidu.com"
  });
}

$.index.open();
