SELECT
    session_id = request_session_id,
    request_owner_type,
    resource_type,
    database_name = D.name,
    object_name = O.name,
    request_mode,
    request_type,
    request_status
FROM sys.dm_tran_locks L
LEFT JOIN sys.databases D ON D.database_id = L.resource_database_id
LEFT JOIN sys.objects   O ON O.object_id   = L.resource_associated_entity_id
ORDER BY
    resource_database_id,
    resource_associated_entity_id,
    request_mode