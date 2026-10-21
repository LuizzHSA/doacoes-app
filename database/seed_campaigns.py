from database.main import criar_campanha


CAMPAIGNS = [
    {
        'campanha_id': 'kits-escolares',
        'titulo': 'Kits Escolares para o Jardim Esperança',
        'categoria': 'Educação',
        'descricao': 'Vamos equipar 50 crianças com o material necessário para um início de ano letivo digno e cheio de potencial.',
        'arrecadado': 3500,
        'meta': 5000,
        'apoiadores': 242,
    },
    {
        'campanha_id': 'cozinha-solidaria',
        'titulo': 'Cozinha Solidária Paraisópolis',
        'categoria': 'Alimentos',
        'descricao': 'Garantindo 500 refeições diárias para famílias em situação de vulnerabilidade.',
        'arrecadado': 15000,
        'meta': 20000,
        'apoiadores': 320,
    },
    {
        'campanha_id': 'agasalho',
        'titulo': 'Campanha do Agasalho',
        'categoria': 'Saúde',
        'descricao': 'Aquecendo famílias durante o inverno com roupas e cobertores.',
        'arrecadado': 2800,
        'meta': 5000,
        'apoiadores': 118,
    },
]


if __name__ == '__main__':
    for campaign in CAMPAIGNS:
        criar_campanha(**campaign)