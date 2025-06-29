import os
import zipfile
import subprocess
from tkinter import *

# Janela principal
janela = Tk()
janela.title("ChromeDriver Installer")
janela.configure(bg="#1e1e1e")
janela.resizable(False, False)

# Tema e estilo
cor_fundo = "#1e1e1e"
cor_texto = "#ffffff"
cor_botao = "#3a3a3a"
cor_botao_texto = "#ffffff"
fonte_padrao = ("Segoe UI", 12)

frame = Frame(janela, bg=cor_fundo)
frame.pack(expand=True)

versao_base = ""
botao_baixar = None

def copiar_texto():
    texto = campo_texto.get("1.0", "end-1c")
    janela.clipboard_clear()
    janela.clipboard_append(texto)

def mostrar_versao():
    global versao_base, botao_baixar  # Adicionado botao_baixar como global
    versao = entrada.get().strip()

    if not versao:
        campo_texto.delete("1.0", END)
        campo_texto.insert("1.0", "Por favor, digite a versão do Chrome.")
        return

    versao_base = versao[:-2] if len(versao) > 2 else versao
    campo_texto.delete("1.0", END)
    campo_texto.insert("1.0", f"Sua versão do Base do Chrome é: {versao_base}")

    # Exibe o botão de baixar após armazenar a versão
    if botao_baixar:
        botao_baixar.grid(row=7, pady=5)  # Mostra o botão
        janela.update_idletasks()
        janela.geometry("")

def baixar_driver():
    global versao_base
    if not versao_base:
        campo_texto.delete("1.0", END)
        campo_texto.insert("1.0", "Por favor, insira a versão do Chrome primeiro!")
        return

    link = f"https://storage.googleapis.com/chrome-for-testing-public/{versao_base}35/win64/chromedriver-win64.zip"
    pasta_download = os.path.join(os.path.expanduser('~'), 'Downloads')
    chromedriver_pasta = os.path.join(pasta_download, 'chromedriver-win64.zip')

    baixar_comando = f'Invoke-WebRequest -Uri \"{link}\" -OutFile \"{chromedriver_pasta}\"'

    with open('baixar_driver.bat', 'w') as bat_file:
        bat_file.write(f'@echo off\npowershell -Command "{baixar_comando}"\n')

    campo_texto.insert(END, f"\n 📥 Fazendo download do chromedriver versão {versao_base}, NÃO FECHE ESSA JANELA ...\n")
    janela.update()

    os.system('baixar_driver.bat')

    campo_texto.insert(END, "\n💾 Download finalizado com sucesso!\nClique em CONTINUAR para instalar.\n")

    botao_confirmar.grid_remove()
    if botao_baixar:
        botao_baixar.grid_remove()  # Esconde o botão após o download
    botao_continuar.grid(row=12, pady=10)

    janela.update_idletasks()
    janela.geometry("")

def continuar_instalacao():
    pasta_download = os.path.join(os.path.expanduser('~'), 'Downloads')
    pasta_zip = os.path.join(pasta_download, 'chromedriver-win64.zip')
    arquivo_zip = os.path.join(pasta_download, 'chromedriver-win64')
    arquivo_exe = os.path.join(arquivo_zip, 'chromedriver.exe')

    Label(frame, text="📦 Extraindo chromedriver...", bg=cor_fundo, fg=cor_texto, font=fonte_padrao).grid(row=8, pady=5)
    janela.update()

    try:
        with zipfile.ZipFile(pasta_zip, 'r') as zip_ref:
            zip_ref.extractall(pasta_download)

        if os.path.exists(arquivo_exe):
            Label(frame, text=f"✔️ Chromedriver extraído em: {arquivo_exe}", bg=cor_fundo, fg=cor_texto, font=fonte_padrao).grid(row=9, pady=5)
            Label(frame, text="🚀 Iniciando chromedriver...", bg=cor_fundo, fg=cor_texto, font=fonte_padrao).grid(row=10, pady=5)
            janela.update()

            try:
                subprocess.Popen(arquivo_exe)
                Label(frame, text="✅ Chromedriver iniciado com sucesso, pode fechar a janela!", bg=cor_fundo, fg=cor_texto, font=fonte_padrao).grid(row=11, pady=5)
            except Exception as e:
                Label(frame, text=f"❌ Erro ao executar chromedriver: {e}", bg=cor_fundo, fg=cor_texto, font=fonte_padrao).grid(row=11, pady=5)
        else:
            Label(frame, text="❌ Erro: chromedriver.exe não encontrado", bg=cor_fundo, fg=cor_texto, font=fonte_padrao).grid(row=9, pady=5)
    except Exception as e:
        Label(frame, text=f"❌ Erro ao extrair: {e}", bg=cor_fundo, fg=cor_texto, font=fonte_padrao).grid(row=9, pady=5)

# Interface visual
Label(frame, text="Copie o link abaixo, cole no navegador Chrome\ne digite a versão abaixo:", bg=cor_fundo, fg=cor_texto, font=fonte_padrao).grid(row=0, pady=10)

campo_texto = Text(frame, height=4, width=45, bg="#2d2d2d", fg=cor_texto, insertbackground="white", font=fonte_padrao)
campo_texto.insert("1.0", "chrome://settings/help")
campo_texto.grid(row=2)

Button(frame, text="Copiar Texto", command=copiar_texto, bg=cor_botao, fg=cor_botao_texto, font=fonte_padrao).grid(row=3, pady=5)

Label(frame, text="DIGITE A SUA VERSÃO DO CHROME (apenas numeros e pontos sem letras):", bg=cor_fundo, fg=cor_texto, font=fonte_padrao).grid(row=4, pady=5)

entrada = Entry(frame, font=fonte_padrao, bg="#2d2d2d", fg=cor_texto, insertbackground="white")
entrada.grid(row=5, pady=5)

botao_confirmar = Button(frame, text="CONFIRMAR", command=mostrar_versao, bg=cor_botao, fg=cor_botao_texto, font=fonte_padrao)
botao_confirmar.grid(row=6, pady=5)

# Botão de download - criado mas escondido inicialmente
botao_baixar = Button(frame, text="BAIXAR CHROMEDRIVER", command=baixar_driver, 
                     bg=cor_botao, fg=cor_botao_texto, font=fonte_padrao)
botao_baixar.grid(row=7, pady=5)  # Posicionado no grid
botao_baixar.grid_remove()  # Imediatamente escondido

# Botão continuar (só depois do download)
botao_continuar = Button(frame, text="CONTINUAR", command=continuar_instalacao, bg="#007acc", fg="white", font=("Segoe UI", 13, "bold"))
botao_continuar.grid(row=12, pady=10)
botao_continuar.grid_remove()  # Escondido inicialmente

# Ajusta layout inicial
janela.update_idletasks()
janela.geometry("")
janela.mainloop()