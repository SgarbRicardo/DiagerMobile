unit unitFrameTask;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation;

type
  TframeTask = class(TFrame)
    lblProgress: TLabel;
    lytProgress: TLayout;
    Rectangle1: TRectangle;
    Layout1: TLayout;
    lblModel: TLabel;
    Layout2: TLayout;
    Label1: TLabel;
    Layout3: TLayout;
    lblYearRange: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
