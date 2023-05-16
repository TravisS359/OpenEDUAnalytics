parameters{
	CheckpointKeySuffix as string ("001")
}
source(output(
		body as (operations as string[], order as short, resource as string),
		headers as [string,string]
	),
	allowSchemaDrift: true,
	validateSchema: false,
	httpMethod: 'GET',
	timeout: 30,
	requestInterval: 0,
	paginationRules: ['supportRFC5988' -> 'true'],
	responseFormat: ['type' -> 'json', 'documentForm' -> 'arrayOfDocuments']) ~> EdFiEntitiesSource
CheckpointKeysFileSelect2 derive(checkpoint = concat(resource, '/', $CheckpointKeySuffix)) ~> CheckpointKeysFileDerived
EdFiEntitiesSource select(skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> CheckpointKeysFileSelect
CheckpointKeysFileSelect select(mapColumn(
		resource = body.resource
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> CheckpointKeysFileSelect2
CheckpointKeysFileDerived sink(allowSchemaDrift: true,
	validateSchema: false,
	partitionFileNames:['checkpoints.json'],
	umask: 0022,
	preCommands: [],
	postCommands: [],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	partitionBy('hash', 1)) ~> CheckpointKeysFile