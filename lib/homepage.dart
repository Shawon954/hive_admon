
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _controller =TextEditingController();
  TextEditingController _updatecontroller =TextEditingController();
    Box? contactBox;
   @override
  void initState() {
    contactBox = Hive.box("Contact_list");
    super.initState();
  }

  var _fromkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact List"),
      centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
        child: Column(
          children: [

            Form(
              key: _fromkey,
              child: TextFormField(
                validator: (val){
                  if(val!.isEmpty){
                    return "Number places";
                  }
                  else if(val.length>11){
                    return "Minimum Number of 11";
                  }
                  else{
                    return null;
                  }
                },
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your Number",
                ),
              ),
            ),
               SizedBox(height: 20,),
            SizedBox(
             width: double.maxFinite,
              child: ElevatedButton(onPressed: (){
                 if(_fromkey.currentState!.validate()){

                 }
                final inputUser = _controller.text;
                contactBox!.add(inputUser);
              

              },
                  child: Text("Contact Number")),
            ),
             Expanded(
                 child: ValueListenableBuilder(valueListenable:Hive.box("Contact_list").listenable(),
                     builder: (context,box,Widget){
                   return ListView.builder(
                       itemCount: contactBox!.keys.toList().length,
                       itemBuilder: (BuildContext context,int index){

                     return Card(
                       child: ListTile(
                         dense: true,
                         title: Text(contactBox!.getAt(index).toString()),
                         trailing: Container(
                           width: 120,
                           child: Row(
                             children: [
                               IconButton(onPressed: (){
                                 showDialog(context: context, builder: (context){
                                   return AlertDialog(

                                     content: Column(
                                       children: [
                                         TextFormField(
                                               keyboardType: TextInputType.number,
                                            controller: _updatecontroller,
                                           decoration: InputDecoration(
                                             hintText: "Update Number",
                                           ),

                                         ),
                                         ElevatedButton(onPressed: ()async{
                                           await contactBox!.putAt(index, _updatecontroller.text);


                                           Navigator.pop(context);
                                         },
                                             child:  Text("Update"),),
                                       ],
                                     ),
                                   );

                                 });
                               },
                                   icon: Icon(Icons.vpn_key_outlined)),
                               SizedBox(width: 10,),
                               IconButton(
                                   onPressed: ()async{
                                 await contactBox!.deleteAt(index);
                               },
                                   icon: Icon(Icons.delete)),
                             ],
                           ),
                         ),
                       ),
                     );
                   });
                     })
             ),
          ],
        ),
      ),
    );
  }
}
