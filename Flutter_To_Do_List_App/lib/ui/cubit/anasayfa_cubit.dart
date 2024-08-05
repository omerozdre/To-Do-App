import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_list_app/data/entitiy/gorevler.dart';
import 'package:flutter_to_do_list_app/data/repo/gorevlerdao_repository.dart';

class AnasayfaCubit extends Cubit<List<Gorevler>>{
  AnasayfaCubit():super(<Gorevler>[]);

  var grepo = GorevlerDaoRepository();

  Future<void> gorevleriYukle() async{//grepo daki gorevleriYukle'yi çalıştırdı
    var liste = await grepo.gorevleriYukle();
    emit(liste);//emit çalıştığı anda AnasayfaCubit' dinleyen yere liste yi gönderdi
  }

  Future<void> ara(String aramaKelimesi) async{
    var liste = await grepo.ara(aramaKelimesi);
    emit(liste);
  }

  Future<void> sil(int gorev_id) async{
    await grepo.sil(gorev_id);//repoya gitti
    await gorevleriYukle();//sildikten sonra arayüzü güncelleyen fonksiyonumuz
  }
}