import 'dart:async';
import 'dart:io';
import 'dart:isolate';

void main(List<String> arguments) {
   
   print('Comenzando Cronometro....');
   await inicio();
   print('Presione enter para terminar');
   await stdin.first;
   stop();
   print('Cronometro detenido con exito');
   exit(0);
}

Isolate isolate;

inicio() async {

ReceivePort receivePort =ReceivePort();

isolate = await isolate.spawn(cronometro, receivePort.sendPort);
receivePort.listen(manejoMensajes, onDone: () => print('Terminado'));

}

cronometro(SendPort sendPort) async {

  int segundos = 0;
  int minutos = 0;

  Timer.periodic(Duration(seconds: 1), (Timer timer){});

  segundos ++;
  if(segundos == 60){
    segundos = 0;
    minutos++;


  }

  String mensaje = '$minutos:$segundos';
  print(mensaje)
  sendPort.send(mensaje);


}

manejoMensajes(dynamic data){

  print('Tiempo transcurrido:  $data ');

}

stop(){

  if(isolate != null){
    print('Terminando Cronometro');
    isolate.kill(priority: Isolate.immediate);
    isolate = null;
  }
}