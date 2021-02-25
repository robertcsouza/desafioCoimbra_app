class Contratante {
  int idContratante;
  String razaoSocial;
  int cnpj;
  int telefone;
  int enderecoFK;

  Contratante(
      {int idContratante,
      String razaoSocial,
      int cnpj,
      int telefone,
      int enderecoFK}) {
    this.idContratante = idContratante;
    this.razaoSocial = razaoSocial;
    this.cnpj = cnpj;
    this.telefone = telefone;
    this.enderecoFK = enderecoFK;
  }

  int get id {
    return idContratante;
  }

  toMap() {
    Map<String, dynamic> map = {
      'razaoSocial': this.razaoSocial,
      'cnpj': this.cnpj,
      'telefone': this.telefone,
      'endereco_idendereco': this.enderecoFK
    };

    return map;
  }
}
