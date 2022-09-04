import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/component/text_style.dart';
import 'package:tec/controller/list_article_controller.dart';
import 'package:tec/controller/single_article_controller.dart';
import 'package:tec/view/single.dart';

class ArticleListScreen extends StatelessWidget {
  ArticleListScreen({Key? key}) : super(key: key);
  ListArcticleController listarcticleController = Get.put(ListArcticleController());
  SingleArcticleController singleArcticleController = Get.put(SingleArcticleController());

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: appBar("مقالات جدید"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Obx(
              () => ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: listarcticleController.articleList.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: (() {
                      singleArcticleController.id.value =int.parse(listarcticleController.articleList[index].id!) ;
                       
                      Get.to(Single());
                    }),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Get.height/6,  
                            width: Get.width/3,
                            child: CachedNetworkImage(
                              imageUrl: listarcticleController.articleList[index].image!,
                              imageBuilder: (((context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                                      image: DecorationImage(
                                          image: imageProvider, fit: BoxFit.cover)),
                                );
                              })),
                            
                              placeholder: (((context, url) {
                                return loading();
                              })),
                              errorWidget: ((context, url, error) {
                                return Icon(Icons.image_not_supported_outlined,size: 50,color:Colors.grey);
                              }),
                            ),
                          )
                          ,
                          SizedBox(width: 16,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Get.width/2,
                                child: Text(
                                  listarcticleController.articleList[index].title!
                                  ,overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  
                                  ),
                              ),
                              SizedBox(height: 16,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                              Text(listarcticleController.articleList[index].author!,style: textTheme.caption,),
                              SizedBox(width: 20,),
                                 Text(listarcticleController.articleList[index].view!+ " بازدید ",style: textTheme.caption,),
                  
                                ],
                              )
                            ],
                          )
                        
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
