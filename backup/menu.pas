unit menu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, fphttpclient,
  opensslsockets;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
     function getCep(cep: string): string;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
 var cepResponse: string;
begin
  cepResponse:= getCep(Edit1.Text);
   if cepResponse <> EmptyStr then
   Memo1.Lines.Add(cepResponse)
   else
     Memo1.Lines.Add('Sem conteúdo para a requisição');
end;
    function TForm1.getCep(cep: string): string;
const
  baseURL: string = 'https://viacep.com.br/ws/';
var
  httpClient: TFPHTTPClient;
begin
  httpClient := TFPHTTPClient.Create(nil);
  try
    Result := httpClient.Get(baseURL + cep + '/json/');
  except
    Result := httpClient.Get('Requisicao falhou');
  end;
  if Assigned(httpClient) then
    FreeAndNil(httpClient);
end;

end.

