У нас есть две основные формы -- Form1 и f2. f2 -- форма с ползунком для радиуса;


1. Создаём RadiusEventArgs. Это класс-наследник от класса EventArgs, имеющий дополнительным параметром радиус типа int. Это происходит в namespace'e;
2. Описать делегата для обработчиков события RadiusChanged;
  public Delegate void RadiusChangedDeleagate(object sender, RadiusEventArgs e);

Код в f2:
  1. Создаётся public event RadiusChangedDeleagate, в котором будет храниться обработчик нашего события;  //event даёт возможность класть функцию в очередь вместо мгновенного вызова;
  2. В форме имеется ползунок со своим событием изменения значения. Работаем в нём:
    if(this.RadiusChanged != null)
      this.RadiusChanged(f2, new RadiusEventArgs(значение_ползунка));

Код в Form1:
  В реакции на пункт меню радиуса:
    Form2 f2 = new Form2();
    f2.RadiusChanged += new RadiusChangedDeleagate(RCEventHandler);
    f2.Show();
  private void RCEventHandler(object sender, RadiusEventArgs e)
  {
    Shape.R = e.Radius;
    Refresh();
  }
