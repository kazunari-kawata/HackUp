<?php
// CORS対策
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header('Content-Type: application/json');

require_once './db.php';

$sql = "SELECT hacks.id, hacks.title, hacks.description, hacks.created_at, users.display_name
        FROM hacks
        JOIN users ON hacks.user_id = users.id
        ORDER BY hacks.created_at DESC";

try {
        $stmt = $pdo->query($sql);
        $hacks = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($hacks);
} catch (PDOException $e) {
        echo json_encode(["sql_error" => "{$e->getMessage()}"]);
        exit();
}
