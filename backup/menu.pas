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
    Button2: TButton;
    Senha: TLabel;
    Usuario: TLabel;
    username: TEdit;
    password: TEdit;
    Memo1: TMemo;
    Edit1: TEdit;
    Memo2: TMemo;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UsuarioClick(Sender: TObject);
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

procedure TForm1.UsuarioClick(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
 var cepResponse: string;
begin
  try
  if Length(Edit1.Text) <> 8 then
  ShowMessage('o cep digitado deve possuir 8 caracteres');
  cepResponse:= getCep(Edit1.Text);

   if cepResponse <> EmptyStr then
   Memo1.Lines.Add(cepResponse)
   else
   Memo1.Lines.Add('Sem conteúdo para a requisição');
   except
      ShowMessage('Erro na requisição');
   end;
end;

procedure TForm1.Button2Click(Sender: TObject);
   var usernameValue: string;
   var passwordValue: string;
begin
  usernameValue := username.Text;
  passwordValue := password.Text;
  if (usernameValue = '') or (passwordValue = '') then
  begin
    ShowMessage('Por favor, informe seu usuário e senha.');
  end
  else
  begin
    if Length(passwordValue) < 6 then
    begin
      ShowMessage('Sua senha precisa ter ao menos 6 caracteres');
    end
    else
    begin
      ShowMessage('Seu nome de usuário é:' + usernameValue);
    end
   end
end;

    function TForm1.getCep(cep: string): string;
const
  baseURL: string = 'https://viacep.com.br/ws/';
var
  httpClient: TFPHTTPClient;
begin
  Result := '';
  httpClient := TFPHTTPClient.Create(nil);
  try
    Result := httpClient.Get(baseURL + cep + '/json/');
  except
    Result := '';
  end;
  if Assigned(httpClient) then
    FreeAndNil(httpClient);
end;


end.

