import 'package:flutter/material.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget? title;
  final double? height;
  final Widget? action;
  final bool hideBack;
  final Color?backgroundColor;
  const BasicAppBar({super.key, this.title, this.hideBack=false,this.action, this.backgroundColor, this.height});
  @override
  Widget build(BuildContext context) {
    return AppBar(backgroundColor: backgroundColor??Colors.transparent,
      title: title??Text(''),
      centerTitle: true,
      elevation: 0,


      leading: hideBack||!Navigator.canPop(context)?null:IconButton(onPressed: (){ if (Navigator.canPop(context)) {
        Navigator.of(context).maybePop();
      }}, icon: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.03),
          shape: BoxShape.circle,),
        child: Icon(Icons.arrow_back_ios_new,
          color:Colors.white,),
      ),
      ),
      actions: [
        action??Container()
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
