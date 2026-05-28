-- DROP FUNCTION dim.usp_get_skus();

CREATE OR REPLACE FUNCTION dim.usp_get_skus()
 RETURNS TABLE(sku_id bigint, sku_name character varying, description text, created_at timestamp without time zone, updated_at timestamp without time zone, created_by character varying, updated_by character varying)
 LANGUAGE plpgsql
AS $function$
begin
	return query SELECT s.sku_id, s.sku_name, s.description, s.created_at, s.updated_at, s.created_by, s.updated_by
				FROM dim.sku s;
end;
$function$
;
