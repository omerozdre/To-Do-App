import 'package:flutter_to_do_list_app/data/entitiy/gorevler.dart';
import 'package:flutter_to_do_list_app/sqlite/veritabani_yardimcisi.dart';

class GorevlerDaoRepository{

   Future<void> gorevKaydet(String gorev_ad,String gorev_tarih, String gorev_saat) async {
     var db = await VeritabaniYardimcisi.veritabaniErisim();

     var yeniGorev = Map<String, dynamic>();
     yeniGorev["gorev_ad"] = gorev_ad;
     yeniGorev["gorev_tarih"] = gorev_tarih;
     yeniGorev["gorev_saat"] = gorev_saat;

     await db.insert("gorevler", yeniGorev);
  }

  Future<void> gorevGuncelle(int gorev_id,String gorev_ad,String gorev_tarih, String gorev_saat) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var guncellenenGorev = Map<String, dynamic>();
    guncellenenGorev["gorev_ad"] = gorev_ad;
    guncellenenGorev["gorev_tarih"] = gorev_tarih;
    guncellenenGorev["gorev_saat"] = gorev_saat;

    await db.update("gorevler", guncellenenGorev, where: "gorev_id = ?", whereArgs: [gorev_id]);
  }

   Future<void> sil(int gorev_id) async{
     var db = await VeritabaniYardimcisi.veritabaniErisim();
     await db.delete("gorevler", where: "gorev_id = ?", whereArgs: [gorev_id]);
   }

   Future<List<Gorevler>> gorevleriYukle() async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM gorevler");

    return List.generate(maps.length, (i){
      var satir = maps[i];

      return Gorevler(
          gorev_id: satir["gorev_id"],
          gorev_ad: satir["gorev_ad"],
          gorev_tarih: satir["gorev_tarih"],
          gorev_saat: satir["gorev_saat"]);
    });
   }

   Future<List<Gorevler>> ara(String aramaKelimesi) async{
     var db = await VeritabaniYardimcisi.veritabaniErisim();
     List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM gorevler WHERE gorev_ad like '%$aramaKelimesi%'");

     return List.generate(maps.length, (i){
       var satir = maps[i];

       return Gorevler(
           gorev_id: satir["gorev_id"],
           gorev_ad: satir["gorev_ad"],
           gorev_tarih: satir["gorev_tarih"],
           gorev_saat: satir["gorev_saat"]);
     });
   }


}