Все события, получаемые программой, ставятся в очередь, каждое следующее выполняется после предыдущего;
Никакие события не должны теряться;
Все события должны обрабатываться в порядке поступления;

События в очереди хранятся как структуры данных, имеющие в себе
  Время отправки;
  Тип события;       //MouseUp, ButtonPress etc.
  Параметры события;
  Адресат;

Форма постоянно вертится в бесконечном цикле, постоянно проверяя очередь событий, и, если находит события, выдёргивает их из очереди и обрабатывает;


Рассмотрим дополнительное окно, в котором у нас появляется слайдер для радиуса. Чтобы передать новый радиус, удобно создать новое событие для передачи радиуса в осоновную форму;
Создаётся событие RadiusChanged и параметр события -- класс-наследник класса EventArgs -- RadiusEventArgs;
Получается, мы обрабатываем событие так -- считываем новый радиус из RadiusEventArgs, записываем его значение в статический радиус класса Shape и перерисовываем форму;


Обработчик события всегда имеет тип void и два параметра -- object sender и EventArgs e;

Объекты зачастую имеют в себе методы, которые можно переназначать. По сути, мы задаём метод для условной кнопки вне самой кнопки, а потом в Дизайнере присваиваем этот метод;
Пример для кнопки:
  this.button.Click /*поле*/ += this.button1_click; /*Обработчик событий, созданный в классе From1*/
C точки зрения низкоуровневого программирования вызов метода -- это goto. По сути, в этой конструкции мы переопределяем то, куда отправит нас эта функция;
Получается, можно несколько объектов свести к одному событию или, наоборот, вызывать несколько событий из одного объекта;


Поле this.button.Click -- это делегат;
Делегат -- это "указатель" на функцию. По сути, хранит адрес, на который нужно перейти;
Формально Delegate -- класс, экземпляром которого может быть функция;

Delegate int SomeDelegate(string s, bool b);      //объявлен класс-делегат
Одна функция может заменить другую только тогда, когда они возвращают одинаковый тип данных и принимают одинаковый набор параметров. При объявлении делегата мы описываем его сигнатуру -- собственно, тип возвращаемого значения и список параметров.
Получается, в нашем делегате могут быть ссылки на функции, которые возвращают тип int и принимают string- и bool-параметры;

Ура, объявили класс. Кстати, делается это, как и для любого другого класса, в namespace'e. Теперь давайте попробуем создать переменную этого класса;

int Function1(string s, bool b)
{
  MessageBox.Show("Function1");
  if(b) return s.Length;
  return -1;
}

int Function2(string s, bool b)
{
  MessageBox.Show("Function2");
  return -20;
}

private void Something()
{
  ...
  SomeDelegate MyDeligate;    //=null
  MyDelegate = new SomeDelegate(Function1);   //создание экземпляра класса-делегата
  MyDelegate += new SomeDelegate(Function2);
  int x = MyDelegate("res", true);            //использование делегата
  MessageBox.Show(x.ToString());
  ...
}

Несмотря на то, что MyDeligate -- объект класса, он сам является функцией. По сути, он принимает в себя функцию и делает ровно то же самое, что и функция.
В нашей записи MyDelegate("test", true); -- это то же самое, что Function1("test", true);

С помощью делегатов можно получать объекты одного и того же класса с разными методами;

Если к делегату присвоены два или более методов, возвращаться будет значение из последнего вызванного;
