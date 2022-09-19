Все классы расположены в namesapce'e;
partial class — класс, часть кода которого находится где-то ещё. К примеру, часть кода формы может быть в дизайнере;


Иерархия многоугольников
abstract class Shape
{
  int x, y;
  static int r;
  static DrawingColor color;

  Shape()
  { this.x = 0; this.y = 0; }
  Shape(int x, int y)
  { this.x = x; this.y = y; }

  static Shape()
  { r = 10; color = DrawingColor.Blue;  } //Вызывается автоматически

  virtual void Draw()  //Отрисовка фигуры
  {  }

  virtual bool isInside(int x, int y){  } //Получает на вход координаты курсора и проверяет, надо ли захватить фигуру на Drag'n'Drop
}
