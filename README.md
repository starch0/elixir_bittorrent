# TorrentManager

**TODO:
- [x]  consertar essa todo list**

## 1. Estrutura Básica do Torrent
- [x] Criar struct básica
- [x] Ler arquivo .torrent
- [x] Extrair informações básicas

## 2. Melhorar a Struct Torrent
- [x] Adicionar info_hash (necessário para o tracker)
- [x] Adicionar pieces (lista de hashes das peças)
- [x] Adicionar piece_length (tamanho de cada peça)
- [ ] Adicionar lista de arquivos para torrents multi-arquivo

## 3. Comunicação com Tracker
- [x] Criar módulo TrackerClient
- [x] Implementar conexão HTTP com tracker
- [x] Gerar peer_id único para identificação
- [x] Montar URL de announce com parâmetros:
  - info_hash
  - peer_id
  - port
  - uploaded
  - downloaded
  - left (bytes restantes)
- [ ] Decodificar resposta do tracker
- [ ] Extrair lista de peers

## 4. Gerenciamento de Peers
- [ ] Criar módulo PeerConnection
- [ ] Implementar conexão TCP com peers
- [ ] Implementar handshake inicial
- [ ] Gerenciar mensagens do protocolo BitTorrent:
  - choke/unchoke
  - interested/not interested
  - have
  - bitfield
  - request
  - piece

## 5. Download Manager
- [ ] Criar sistema de peças pendentes/completas
- [ ] Implementar verificação de hash das peças
- [ ] Gerenciar download paralelo de múltiplas peças
- [ ] Salvar arquivos no disco
- [ ] Implementar pausa/retomada de downloads

## 6. Interface de Usuário
- [ ] Criar comandos básicos:
  - adicionar torrent
  - listar torrents
  - ver status
  - pausar/retomar
- [ ] Mostrar progresso do download
- [ ] Mostrar velocidade de download/upload
- [ ] Mostrar peers conectados

## 7. Extras (Para Futuro)
- [ ] Suporte a DHT (Distributed Hash Table)
- [ ] Suporte a magnet links
- [ ] Configurações de largura de banda
- [ ] Sistema de prioridade de arquivos
- [ ] Interface web

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `torrent_manager` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:torrent_manager, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/torrent_manager>.

