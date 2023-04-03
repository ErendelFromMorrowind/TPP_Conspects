У нас создаётся ещё один тип вершины, наследуемый от Shape'a;
Есть скомпилированный проект с тремя вершинами и механзим, позволяющий спереть из нужной папки дополнительный плагин из заданной папки уже ПОСЛЕ компиляции;

Рефлексия -- по сути, внесение изменений в код, который выполняется;
Существует класс Assembly. В нём содержится кусок кода, который будет разбираться.

1. Грузим библиотеку:
Assembly myAssembly = Assembly().LoadFine("MyLib.DLL");     //ссылка на скомпилированный код

2. Достаём из библиотеки нужный нам класс:
Type myType = myAssembly.GetType("myClass"); ссылка на скомпилированный класс;
Проблема в том, что мы не знаем названия класса. Для удобства работы плагины имеют стандарт.
В каждом плагине описан только один класс;

Type [] myTypes = myAssembly.GetTypes();  //массив, в котором грузятся все полученные классы
Но у нас-то один класс!

Type myType = myAssembly.GetTypes()[0];

3. Создаём экземпляр класса:
Object myInstance = Arctivator.CreateInstance(myType);   //эквивалетно myInstance = new myType(), но такая запись невозможна синтаксически;

Проблема такой записи в том, что при такой записи мы не передаём параметры, даже не зная, сколько надо передать;
Для перебачи будет использоваться List<Object>;

Нам нужно сделать что-то типа myInstance = new myType(100, 100);
Для этого:
Object[] params = {100, 100};

Object myShape = Activator.CreateInstance(myType, params);


4. Вызываем методы:
MethodInfo myMethod = myType.GetMethod("Draw");   //только для неперегруженных методов

MethodInfo myStaticMethod = myType.GetMethod("MethodOne", BindingFlags.Static | BindingFlags.Public, null, new Type[] {typeof(Int32), typeof(string)}, null);

Object[] params = {e.Graphics};
myMethod.Invoke(myShape, params);
myStaticMethod.Invoke(args);


5. Поля:
FieldInfo myX = myType.GetField("X");
int X = (int)myX.GetValue(myShape);     //эквивалентно x = myShape.X;

Для записи вместо GetValue используется SetValue:
  myX.SetValue(myShape, 1984);



При чтении плагинов нам надо добавить новый тип вершины в меню. Для этого нужно считать название. Тут есть два варианта -- или использовать название файла, или дописать специальный статический метод для этого;
Само меню надо менять через Designer. Это довольно просто, но требует раскапывания. Затем надо ещё и обработчики к этому сделать;
