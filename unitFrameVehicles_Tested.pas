unit unitFrameVehicles_Tested;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts;

type
  TframeVehicleTested = class(TFrame)
    Rectangle1: TRectangle;
    lblTester: TLabel;
    lblData: TLabel;
    lblLocation: TLabel;
    Layout1: TLayout;
    Layout2: TLayout;
    lblEng: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
