
# Criar roles
administrador_role = Role.find_or_create_by!(name: 'administrador')
gerente_de_projeto_role = Role.find_or_create_by!(name: 'gerente_de_projeto')
membro_da_equipe_role = Role.find_or_create_by!(name: 'membro_da_equipe')
convidado_role = Role.find_or_create_by!(name: 'convidado')

Usuario.find_or_create_by!(email: 'usuario@example.com') do |usuario|
  usuario.nome_completo = 'Nome do Usuário'
  usuario.data_nascimento = Date.parse('1990-01-01')
  usuario.telefone = '85996861158'
  usuario.usuario_git = 'https://github.com/PauloRibeiro167'
  usuario.url_foto_perfil = 'https://example.com/foto.jpg'
  usuario.role = administrador
  usuario.status = 'ativo'
end