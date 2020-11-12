unit uFunctions;

interface
  uses fmx.ani, fmx.forms,SysUtils, Variants, Classes, fmx.Graphics, fmx.Controls,
  fmx.Dialogs, fmx.Edit;

  procedure AnimationMenuOpen(Sender: TObject);
  procedure LimpaEdits(vform: Tform);


implementation

procedure AnimationMenuOpen(Sender: TObject);
var
  animaMargin, animaRotation, animaWidth, animaOpacity: TFloatAnimation;
  i : integer;
  vform : Tform;
Begin
   // for I := 0 to vform.ComponentCount - 1  do
     // if vform.Components[i] is TFloatAnimation then
       //   (vform.Components[i] as animaMargin).Inverse := false;
       //animaMargin :=
   //    with    do




end;

procedure LimpaEdits(vform: Tform);
var
i : Integer;
begin
    for i := 0 to vForm.ComponentCount - 1 do
      if vForm.Components[i] is TCustomEdit then
        (vForm.Components[i] as TCustomEdit).Text.Empty;
end;

end.
