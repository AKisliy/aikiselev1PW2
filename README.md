# aikiselev1PW2
Homework2 Repositoriy
1) What does the code on lines 25 and 29 do?
   На 25 строке, мы говорим компилятору, чтр для данного элемента не надо применять авто компоновку
   На 29 строке мы привязываем к главному view subview и потом можем располагать subview относительно view.
3) What is a safe area layout guide?
   Safe layout guide - зона, в которой объекты будут отображаться корректно, не вылезая за скругленные углы экрана, не залезая на "вырез" камеру и т.д
4) What is [weak self] on line 23 and why it is important?
  Weak self - это список захвата, который используется в замыканиях для создания "слабых" ссылок на класс или структуру. В данном случае, если не использовать слабое связывание, то произойдет цикл в замыкании.
5) What does clipsToBounds mean?
   Булевское значение, показывающее должно ли subview вписываться в границы view
6) What is the valueChanged type? What is Void and what is Double?
   valueChanged соответствует функции, которая принимает параметр типа double и ничего не возвращает(void)
   
   
